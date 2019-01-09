class SitesController < ApplicationController
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
    @submissions = smart_listing_create :submissions, @site.submissions, partial: "sites/submission_list"
    # binding.pry
    # @sites_submissions
  end

  private
  def set_site
    @site = Site.find(params[:id])
  end

  def site_params
    params.require(:site).permit(:id, :name, :latitude, :longitude, :visits, :visitors, :pic_id, :notes)
  end


  def smart_listing_render_foo name = controller_name, *args
    options = args.dup.extract_options!
    
    smart_listing_for(name, *args) do |smart_listing|
      binding.pry
      concat(smart_listing.render_list(options[:locals]))
    end
  end
end
