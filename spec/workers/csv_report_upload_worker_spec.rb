require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe CsvReportUploadWorker, type: :worker do
  let(:file_path)   { 'spec/fixtures/assets/basic.csv' }
  let(:date)        { Date.today - 1.week }
  let(:csv_file)    { Rack::Test::UploadedFile.new(file_path, 'text/csv', true)  }


  describe "#perform" do
    context "when called" do
      let(:date) { '01/01/1800'.to_date }
      it "creates an async job" do

        expect {
          CsvReportUploadWorker.perform_async(csv_file, date)
        }.to change(CsvReportUploadWorker.jobs, :size).by(1)
      end
    end
  end
end