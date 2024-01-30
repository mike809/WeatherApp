class Forecast
  attr_accessor :periods, :location, :data_state, :zipcode, :errors

  delegate :coordinates, :postal_code, :address, to: :location

  def initialize
    @data_state = :cached
    @periods = []
    @errors = []
  end

  def location=(location)
    @location = location
    @zipcode = location&.postal_code.presence || location&.address&.match(/\d{5}(-\d{4})?/)

    errors << "No location found for this address." if @location.nil?
    errors << "No zipcode found for this address." if @zipcode.nil?
  end
end
