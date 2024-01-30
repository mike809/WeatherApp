module WeatherForecastHelper
  def format_weather_card_time(time_string)
    Time.parse(time_string).strftime("%A %d at %l:%M %p")
  end
end
