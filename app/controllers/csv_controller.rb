class CsvController < ApplicationController
  before_action :redirect_unless_admin
  # TODO - add date in
  def index
  end

  def create
    date = params["from_date"]
    file = params["CSV-file"].read
    data = JSON.parse(file)
    
    InstaBacklogJob.new(data, date).perform
    redirect_to '/admin'
  end
end