class Location < ApplicationRecord
  belongs_to :user
  geocoded_by :address

  after_validation :geocode, if: ->(obj) { obj.address.present? && obj.address_changed? }

  def coordinates
    [latitude, longitude]
  end

  def forecast
    cache_key = "forecast_#{coordinates.join('_')}"
    Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      WeatherForecastService.new(address).call
    end
  end
end
