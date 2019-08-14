class ApplicationController < ActionController::Base
  include HttpAuthConcern
  protect_from_forgery with: :exception

  def redirect_unless_admin
    unless current_user.try(:admin?)
      redirect_to '/admin' 
      flash[:notice] = 'Sorry, you have to be an admin to do that!'
    end
  end
end
