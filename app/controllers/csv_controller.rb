class CsvController < ApplicationController

  def results
    respond_to do |format|
      format.csv { send_data sort_images.to_csv, filename: "collection-#{Date.today}.csv" }
    end
  end

  private

  def sort_images    
    options = {}
    options = options.merge(query: filter) if filter.present?
    
    Image.all_with_filter(options, scope)
  end

  def scope
    reliable_images? ? Image.all.reliable : Image.all
  end

  def reliable_images?
    permitted_params[:reliable_filter] == "0"
  end

  def filter
    permitted_params[:filter]
  end

  def permitted_params
    params.permit(:filter, :reliable_filter)
  end
end