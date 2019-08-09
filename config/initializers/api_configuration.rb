ApiPagination.configure do |config|
  # Set header with current page number
  config.page_header = 'current-page'
  
  # Total
  config.total_header = 'Total'
  
  config.page_param = :page
  config.page_param do |params|
    if params[:page].is_a?(ActionController::Parameters)
      params[:page][:number]
    else
      params[:page]
    end
  end
    
  config.per_page_param do |params|
    params[:page][:size] if params[:page].is_a?(ActionController::Parameters)
  end
end