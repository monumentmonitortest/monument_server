class Image < ApplicationRecord
  validates :url, presence: true,
                    length: { minimum: 5 }

  SITES = ["MACHRIE", "HOLYROOD"]
  SOURCE = ["TWITTER", "INSTAGRAM", "UPLOAD"]

  def self.to_csv
    attributes = %w{id url site watson_info weather_info reliable date_taken insta_user_id twitter_user_id source created_at updated_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |image|
        csv << attributes.map{ |attr| image.send(attr) }
      end
    end
  end

  def machrie?
    self.site == "MACHRIE"
  end

  def holyrood?
    self.site == "HOLYROOD"
  end
end
