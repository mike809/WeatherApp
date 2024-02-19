class Forecast
  attr_accessor :periods, :location, :data_state, :zipcode, :errors

  delegate :coordinates, :postal_code, :address, to: :location

  def initialize
    @data_state = :cached
    @periods = []
    @errors = []
  end

  def location=(forecast_location)
    @location = forecast_location
    @zipcode = forecast_location&.postal_code.presence || forecast_location&.address&.match(/\d{5}(-\d{4})?/)[0]

    errors << "No location found for this address." if @location.nil?
    errors << "No zipcode found for this address." if @zipcode.nil?
  end
end
