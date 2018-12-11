class Submission < ApplicationRecord
  belongs_to :site
  belongs_to :type

  # when they are scraped, it will be 'unclassified' (no site)
  # TODO: should maybe have validation on type
end