class SitesController < ApplicationController
  before_action :redirect_unless_admin

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :set_site, only: [:show, :edit, :update, :destroy]
  
  def index
    @sites = Site.all
  end
  
  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      redirect_to @site
    else
      render 'new'
    end
  end

  def update
    @site.update_attributes(site_params)
    if @site.save
      redirect_to @site
    else
      render 'edit'
    end
  end

  def show
    @submissions = @site.submissions.order(:record_taken).page params[:page]
  end

  private
  def set_site
    @site = Site.find(params[:id])
  end

  def site_params
    params.require(:site).permit(:id, :name, :latitude, :longitude, :visits, :visitors, :pic_id, :notes)
  end
end
