class Image < ApplicationRecord
  validates :url, presence: true,
                    length: { minimum: 5 }

  SITES = ["MACHRIE", "HOLYROOD"]
  SOURCE = ["TWITTER", "INSTAGRAM", "UPLOAD"]

  def self.to_csv
    attributes = %w{id url site watson_info weather_info reliable record_taken insta_user_id twitter_user_id source created_at updated_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |image|
        csv << attributes.map do |attr|
          if attr == 'weather_info'
            set_weather_attribute(image, attr)
          else
           image.send(attr)
          end
        end
      end
    end
  end

  def self.set_weather_attribute(image, attr)
    !image.send(attr).nil? ? image.send(attr)["data"][0] : image.send(attr)
  end

  def machrie?
    self.site == "MACHRIE"
  end

  def holyrood?
    self.site == "HOLYROOD"
  end
end
