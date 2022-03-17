class BasicSubmissionReportJob
  def perform
    attributes = %w[submission-id site-name record-taken record_submitted type-name comment tag_list metadata image_url]

    CSV.open(Rails.root.join('tmp', "basic_submissions.csv"), "wb") do |csv|
      csv << attributes
  
      Submission.all.includes([:site]).each do |submission|
        record_taken = submission.record_taken || submission.submitted_at || submission.created_at
        record_submitted = submission.submitted_at || submission.created_at
        row = [
          submission.id, 
          submission.site_name, 
          record_taken.strftime('%d/%m/%Y'), 
          record_submitted.strftime('%d/%m/%Y'),
          submission.type_name, 
          submission.comment, 
          submission.tag_list,
          submission.metadata,
          submission.image_url, 
        ]
        csv << row
      end
    end
  end
end