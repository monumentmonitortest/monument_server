class Submission < ApplicationRecord
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  belongs_to :site
  has_one :type,  :dependent => :destroy
  accepts_nested_attributes_for :type
  
  validate :validate_site_id
  validates_presence_of :record_taken

  has_one_attached :image
  # to get url for image when developing API - use s.image.service_url

  scope :reliable, -> { where(reliable: true) }
  
  scope :exclude_unsorted, ->(id) { 
    where.not(site_id: id)
  }

  scope :search_site, ->(site_id) {
    if site_id.present?
      where(site_id: site_id)
    end
  }

  scope :type_search, ->(type_name) {
    if type_name.present?
      type_name.upcase!
      joins(:type).where(types: { name: type_name})
    end
  }

  scope :with_tag,  ->(tag) { 
    if tag.present?
      tagged_with(tag) 
    end
  }
  
  def type_name
    @type_name ||= type.present? ? type.name : ""
  end

  def site_name
    @site_name ||= site.name
  end
  
  private

  def validate_site_id
    errors.add(:site_id, "site id is invalid") unless Site.exists?(self.site_id)
  end
end