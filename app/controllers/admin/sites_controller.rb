class Admin::SitesController < ApplicationController
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
      redirect_to admin_sites_path
    else
      render 'new'
    end
  end

  def update
    @site.update(site_params)
    if @site.save
      redirect_to admin_site_path(@site)
    else
      render 'edit'
    end
  end

  def show
    @submissions = @site.submissions.includes(query_includes).order(:record_taken).page(params[:page]).per(100)
  end

  def query_includes
    # {
       [{image_attachment: :blob}, :taggings]
    # }
  end

  def destroy
    # binding.pry
    if @site.submissions.present?
      flash[:notice] = 'Cannot delete a site that has associated submissions'
      redirect_to admin_site_path(@site)
    else
      @site.destroy
      render json: { deleted: true }, status: :no_content
    end
  end

  private
  def set_site
    @site = Site.find(params[:id])
  end

  def site_params
    params.require(:site).permit(:id, :name, :latitude, :longitude, :visits, :visitors, :pic_id, :notes, :site_group_id)
  end
end
