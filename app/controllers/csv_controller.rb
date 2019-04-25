class CsvController < ApplicationController
  # TODO: change to fit with sites and submissions
  # def results
  #   respond_to do |format|
  #     format.csv { send_data sort_images.to_csv, filename: "collection-#{Date.today}.csv" }
  #   end
  # end

<<<<<<< HEAD
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
=======
  # private

  # def sort_images
  #   options = {}
  #   options = options.merge(query: filter) if filter.present?
    
  #   Image.all_with_filter(options, scope)
  # end

  # def scope
  #   reliable_images? ? Image.all.reliable : Image.all
  # end

  # def reliable_images?
  #   permitted_params[:reliable_filter] == "1"
  # end

  # def filter
  #   permitted_params[:filter]
  # end

  # def permitted_params
  #   params.permit(:filter, :reliable_filter)
  # end
>>>>>>> comment out CSV controller until it is updated for new sites and submissions
end