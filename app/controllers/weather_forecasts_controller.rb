class WeatherForecastsController < ApplicationController

  def create
    @forecast = WeatherForecastService.new(params[:address]).call
    render :new, status: 301
  end

  private

  def weather_forecast_params
    params.require(:weather_forecast).permit(:address)
  end
end
