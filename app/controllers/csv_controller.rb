class CsvController < ApplicationController
  before_action :redirect_unless_admin

  def results
    respond_to do |format|
      format.csv { send_data create_csv, filename: "collection-#{Date.today}.csv" }
    end
  end
  
  private
  
  def create_csv
    options = {}
    # TODO, get options with filter working when you can search for specific types
    # options = options.merge(query: filter) if type_filter.present?

    ::CSVCreateService.new(permitted_params).create
  end

  def scope
    # this will scope on reliable images when implemented
    # reliable_images? ? Image.all.reliable : Image.all
  end

  def site
    Site.find(permitted_params[:site_id])
  end

  def permitted_params
    params.permit(:filter, :reliable_filter, :site_id)
  end
end