module WeatherSearchHelper
  def format_weather_card_time(time_string)
    Time.parse(time_string).strftime("%A %d at %l:%M %p")
  end

  def format_temperature(temperature)
    temperature.to_f.round(2)
  end

end
