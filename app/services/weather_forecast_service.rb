class WeatherForecastService
  attr_reader :data_state

  def initialize(address)
    @address = address
    @data_state = :cached
  end

  def call
    result = Geocoder.search(@address)
    zipcode = result.first.postal_code

    Rails.cache.fetch(zipcode, expires_in: 30.minutes) do
      @data_state = :fresh
      coordinates = result.first.coordinates
      get_forecast(coordinates)
    end
  end

  private

  def get_forecast(coordinates)
    url = "https://api.weather.gov/points/#{coordinates[0]},#{coordinates[1]}"
    response = HTTParty.get(url)

    forecast_url = JSON.parse(response)["properties"]["forecast"]
    forecast = JSON.parse(HTTParty.get(forecast_url))
  end
end
