class Image < ApplicationRecord
  validates :url, presence: true,
                    length: { minimum: 5 }

  SITES = ["MACHRIE", "HOLYROOD"]
  SOURCE = ["TWITTER", "INSTAGRAM", "UPLOAD"]

  def machrie?
    self.site == "MACHRIE"
  end

  def holyrood?
    self.site == "HOLYROOD"
  end
end
