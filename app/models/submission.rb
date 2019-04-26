class Submission < ApplicationRecord
  belongs_to :site
  has_one :type,  :dependent => :destroy
  accepts_nested_attributes_for :type

  has_attached_file :image, styles: {
    thumb: '100x100>',
    medium: '300x300>'
  }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validate :validate_site_id
  # when they are scraped, it will be 'unclassified' (no site)

  def type_name
    @type_name ||= type.name
  end

  def site_name
    @site_name ||= site.name
  end
  
  def image_url
    @image_url ||= image.url
  end
  private

  def validate_site_id
    errors.add(:site_id, "site id is invalid") unless Site.exists?(self.site_id)
  end
end