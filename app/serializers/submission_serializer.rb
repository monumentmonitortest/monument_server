class SubmissionSerializer < ActiveModel::Serializer
  attributes :id, :site_id, :record_taken, :tags, :image
end
