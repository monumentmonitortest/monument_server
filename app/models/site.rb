class Site < ApplicationRecord
  has_many :submissions
  belongs_to :site_group
  
  UNSORTED_SITES = ['Instagram unsorted', 'Twitter unsorted', 'Unsuitable'].freeze
end