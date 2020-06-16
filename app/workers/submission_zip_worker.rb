class SubmissionZipWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(site_id)
    ImageZipCreationService.new(site_id).create
  end
end
