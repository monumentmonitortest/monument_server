require 'httparty'

class WeatherJob
  def perform
    Image.where(weather_info: nil).each do |image|
      if image.machrie?
        image.weather_info = get_machrie_info(image)
      else image.holyrood?
        image.weather_info = get_holyrood_info(image)
      end

      image.save
    end
  end

  def get_machrie_info(image)
    @machrie_info ||= WeatherInfo.new(image).get_info
  end

  def get_holyrood_info(image)
    @holyrood_info ||= WeatherInfo.new(image).get_info
  end
end
