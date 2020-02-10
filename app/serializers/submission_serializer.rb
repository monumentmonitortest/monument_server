class SubmissionSerializer < ActiveModel::Serializer
  attributes :id, :siteName, :siteId, :recordTaken, :ai_tags, :imageUrl, :typeName, :typeComment, :tags

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

  def typeComment
    self.object.type.comment
  end

  def recordTaken
    self.object.record_taken
  end

  def ai_tags
    # sorts the tags by most likely, then reverses them, then splats them out as an array
    self.object.ai_tags.sort_by {|_key, value| value}.reverse
  end

end
