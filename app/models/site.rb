class Site < ApplicationRecord
  has_many :submissions

  UNSORTED_SITES = ['Instagram unsorted', 'Twitter unsorted', 'Unsuitable'].freeze
end