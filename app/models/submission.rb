class Submission < ApplicationRecord
  belongs_to :site
  belongs_to :type
  
  validates_presence_of :type_id
  # validates site_id is an actual site

  
  # when they are scraped, it will be 'unclassified' (no site)
  # TODO: should maybe have validation on type
end