class Submission < ApplicationRecord
  belongs_to :site
  has_one :type,  :dependent => :destroy
  accepts_nested_attributes_for :type

  # validates site_id is an actual site

  
  # when they are scraped, it will be 'unclassified' (no site)
  # TODO: should maybe have validation on type
end