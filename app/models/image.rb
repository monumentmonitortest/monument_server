class Image < ApplicationRecord
  validates :url, presence: true,
                    length: { minimum: 5 }
end
