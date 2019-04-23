class Submission < ApplicationRecord
  belongs_to :site
  has_one :type,  :dependent => :destroy
  accepts_nested_attributes_for :type

  # validates site_id is an actual site

  validate :validate_site_id
  # when they are scraped, it will be 'unclassified' (no site)

  private

  def validate_site_id
    errors.add(:site_id, "site id is invalid") unless Site.exists?(self.site_id)
  end
end