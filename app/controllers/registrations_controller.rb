class RegistrationsController < ApplicationController
  before_action :redirect_unless_admin

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def new
    @registration = Registration.new(site_id: params[:site_id])
    @site = Site.find(params[:site_id])
    @presenter = ::Registrations::BasePresenter.new(@registration, view_context)
  end

  def create
    @registration = Registration.new(permitted_params)

    if @registration.save
      redirect_to site_url(permitted_params[:site_id]), notice: 'Registration successful!'
    else
      # TODO - get some form of feedback for when uploading doesn't work...
      render :new, notice: "Whoops! Looks like you've missed something out"
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