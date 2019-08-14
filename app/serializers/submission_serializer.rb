class SubmissionSerializer < ActiveModel::Serializer
  attributes :id, :siteName, :siteId, :recordTaken, :tags, :imageUrl, :typeName,

  def imageUrl
    if Rails.env == 'development'
      ActiveStorage::Current.set(host: "localhost:3000") do
        self.object.image.attachment.service_url
      end
    else
      self.object.image.attachment.service_url
    end
  end

  def siteName
    self.object.site.name
  end

  def siteId
    self.object.site_id
  end

  def typeName
    self.object.type.name
  end

  def recordTaken
    self.object.record_taken.strftime("%d/%m/%Y")
  end

end