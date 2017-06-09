require 'httparty'

class WeatherInfo
  MACHRIE = {lat: 55.557572, long: -5.3425987}
  HOLYROOD = {lat: 55.9526539, long: -3.174227}

  def initialize(image)
    if image.machrie?
      @lat = MACHRIE[:lat]
      @long = MACHRIE[:long]
    else image.holyrood?
      @lat = HOLYROOD[:lat]
      @long = HOLYROOD[:long]
    end
  end

  def get_info
    @info ||= HTTParty.get("http://api.openweathermap.org/data/2.5/weather?lat=#{@lat}&lon=#{@long}&appid=#{ENV['OPEN_WEATHER_API_KEY']}")
  end
end
