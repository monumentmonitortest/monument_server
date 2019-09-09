class CsvController < ApplicationController
  before_action :redirect_unless_admin

  def index
  end

  def create
    date = params["from_date"]
    file = params["CSV-file"].read
    data = JSON.parse(file)
    
    InstagramUploadJob.perform(data, date)
    redirect_to '/admin'
  end
end