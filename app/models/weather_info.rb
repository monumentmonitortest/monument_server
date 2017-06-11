require 'httparty'

class WeatherInfo
  MACHRIE = {lat: 55.557572, long: -5.3425987}
  HOLYROOD = {lat: 55.9526539, long: -3.174227}

  def initialize(image)
    @date = image.date_taken? ? image.date_taken : image.created_at
    if image.machrie?
      @lat = MACHRIE[:lat]
      @long = MACHRIE[:long]
    else image.holyrood?
      @lat = HOLYROOD[:lat]
      @long = HOLYROOD[:long]
    end


  end

  def get_info
    @info ||= HTTParty.get("https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/#{@lat},#{@long},#{@date.yesterday.to_time.to_i}")
    @info['daily']
  end
end
