class Site < ApplicationRecord
  has_many :submissions

  UNSORTED_SITES = ['Instagram unsorted', 'Twitter unsorted', 'unidentified'].freeze
end