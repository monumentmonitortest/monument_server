class Admin::ReportUploadController < ApplicationController
  before_action :redirect_unless_admin

  def index
  end

  def create
    date = permitted_params[:from_date]
    file = permitted_params[:file]

    if file.present? && file.content_type == 'text/csv'
      csv_table = CSV.parse(File.read(file), headers: true)
      CsvReportUploadWorker.perform_async(csv_table, date)
      flash[:notice] = 'Report uploading started'
    else
      flash[:notice] = 'Make sure to upload a valid CSV file'
    end

    redirect_back(fallback_location: admin_report_upload_index_path)
  end

  private

  def permitted_params
    params.permit(:from_date, :file)
  end
end