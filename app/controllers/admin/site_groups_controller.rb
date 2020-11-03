class Admin::SiteGroupsController < ApplicationController
  before_action :redirect_unless_admin

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :set_site_group, only: [:show, :edit, :update, :destroy]
  
  def index
    @site_groups = SiteGroup.all
  end
  
  def new
    @site_group = SiteGroup.new
  end

  def create
    @site_group = SiteGroup.new(site_params)
    if @site_group.save
      redirect_to @site_group
    else
      render 'new'
    end
  end

  def update
    @site_group.update_attributes(site_params)
    if @site_group.save
      redirect_to @site_group
    else
      render 'edit'
    end
  end

  def show
    @sites = @site_group.sites
  end

  private
  def set_site_group
    @site_group = SiteGroup.find(params[:id])
  end

  def site_params
    params.require(:identifier, :name)
  end
end
