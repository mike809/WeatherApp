class WeatherForecastsController < ApplicationController

  def create
    weather_forecast_service = WeatherForecastService.new(params[:address])
    @forecast = weather_forecast_service.call
    @data_state = weather_forecast_service.data_state
    render :new, status: 301
  end

  private

  def weather_forecast_params
    params.require(:weather_forecast).permit(:address)
  end
end
