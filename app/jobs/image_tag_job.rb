require "google/cloud/vision"

class ImageTagJob
  def perform
    submissions = Submission.where(tags: {}).first(100)

    submissions.each do |submission|
      get_tags(submission)
    end
  end

  private

  def get_tags(submission)
    detect_obj = image_annotator.label_detection image: submission.image.attachment.service_url

    detect_obj.responses.each do |response|
      response.label_annotations.each do |object|
        submission.tags[object.description] = object.score
        submission.save
      end
    end
    puts "submission tags updated"
  end

  def image_annotator
    @image_annotator ||= Google::Cloud::Vision::ImageAnnotator.new
  end
end
