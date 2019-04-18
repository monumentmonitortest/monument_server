class RegistrationsController < ApplicationController
  
  def new
    @registration = Registration.new(site_id: params[:site_id])
    @site = Site.find(params[:site_id])
    @presenter = ::Registrations::BasePresenter.new(@registration, view_context)
  end

  
  def create
    @registration = Registration.new(permitted_params)

    if @registration.save
      redirect_to root_url, notice: 'Registration successful!'
    else
      render :new
    end
  end

  private

  def permitted_params
    params.require(:registration).permit(:reliable, 
                                         :site_id,
                                         :image,
                                         :record_taken, 
                                         :type_name, 
                                         :email_address, 
                                         :number, 
                                         :insta_username, 
                                         :twitter_username)
  end
end