class CsvReportUploadWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(csv_table, date)
    table = CSV.parse(csv_table, headers: true)
    
    table.each do |submission_row|
      CsvReportUploadJob.new(submission_row, date).create_submission
    end
  end
end
