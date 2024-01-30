class WeatherForecastService
  attr_reader :data_state, :forecast, :location

  def initialize(address)
    @address = address
  end

  def call
    Forecast.new.tap do |forecast|
      forecast.location = Geocoder.search(@address).first
      return forecast unless forecast.zipcode.present?

      forecast.periods = Rails.cache.fetch(forecast.zipcode, expires_in: 30.minutes) do
        forecast.data_state = :fresh
        forecast.coordinates
        get_forecast_periods(forecast)
      end
    end
  end

  private

  def get_forecast_periods(forecast)
    coordinates = forecast.coordinates
    url = "https://api.weather.gov/points/#{coordinates[0]},#{coordinates[1]}"
    response = HTTParty.get(url)

    forecast_url = JSON.parse(response)["properties"]["forecast"]
    response = HTTParty.get(forecast_url)

    if response.success?
      forecast.periods = JSON.parse(response)["properties"]["periods"]
    else
      forecast.errors = JSON.parse(response)["title"]
    end
  end
end
