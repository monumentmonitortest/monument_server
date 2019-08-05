class SubmissionSerializer < ActiveModel::Serializer
  attributes :id, :siteName, :siteId, :recordTaken, :tags, :imageUrl, :typeName,

  def imageUrl
    self.object.image.attachment.service_url
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
