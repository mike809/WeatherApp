class WeatherForecastsController < ApplicationController

  def new
    @forecast = Forecast.new
  end

  def create
    @forecast = WeatherForecastService.new(weather_forecast_params).call
    if @forecast.periods.present?
      data_state = @forecast.data_state
      flash.now[data_state == :cached ? :warning : :success] = "This data is #{data_state}."
    else
      flash.now[:error] = @forecast.errors
    end

    render :new, status: 301
  end

  private

  def weather_forecast_params
    params.require(:address)
  end
end
