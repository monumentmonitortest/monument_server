require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe SubmissionZipWorker, type: :worker do
  let(:site) { create(:site) }
  
  describe "#perform" do

    context "when called" do
      it "creates an async job" do
        expect {
          described_class.perform_async(site.id)
        }.to change(SubmissionZipWorker.jobs, :size).by(1)
      end

      # Sidekiq::Testing.inline! do
      it "calls image zip creation service" do
        service = double("service double")
        allow(ImageZipCreationService).to receive(:new).and_return(service)
        allow(service).to receive(:create)
        
        expect(service).to receive(:create)#.with(site.id)
        described_class.perform_async(site.id)
        Sidekiq::Worker.drain_all
      end
    end
  end
end
