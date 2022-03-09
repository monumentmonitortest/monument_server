class ReportUploadController < ApplicationController
  before_action :redirect_unless_admin

  def index
  end

  def create
    date = params["from_date"]
    file = params["CSV-file"]
    CsvReportUploadWorker.perform_async(file, date)
    redirect_to '/admin'
  end
end