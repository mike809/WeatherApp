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
        get_forecast_periods(forecast)
      end
    end
  rescue StandardError => e
    forecast.errors << e.message
    forecast
  end

  private

  def get_forecast_url(coordinates)
    url = "https://api.weather.gov/points/#{coordinates[0]},#{coordinates[1]}"
    response = HTTParty.get(url)
    raise "Failed to get forecast URL: #{response['title']}" unless response.success?

    JSON.parse(response)["properties"]["forecast"]
  end

  def get_forecast_periods(forecast)
    forecast_url = get_forecast_url(forecast.coordinates)
    response = HTTParty.get(forecast_url)
    raise "Failed to get forecast periods: #{response['title']}" unless response.success?

    JSON.parse(response)["properties"]["periods"]
  rescue StandardError => e
    forecast.errors << e.message
    []
  end
end
