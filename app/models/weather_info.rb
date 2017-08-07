require 'httparty'

class WeatherInfo
  MACHRIE = {lat: 55.557572, long: -5.3425987}
  HOLYROOD = {lat: 55.9526539, long: -3.174227}

  def initialize(image)
    @date = image.record_taken? ? image.record_taken.to_i / 10 : image.created_at.yesterday.to_i
    if image.machrie?
      @lat = MACHRIE[:lat]
      @long = MACHRIE[:long]
    else image.holyrood?
      @lat = HOLYROOD[:lat]
      @long = HOLYROOD[:long]
    end


  end

  def get_info
    @info ||= HTTParty.get("https://api.darksky.net/forecast/#{ENV['DARK_SKY_API_KEY']}/#{@lat},#{@long},#{@date}")
    @info['daily']
  end
end
