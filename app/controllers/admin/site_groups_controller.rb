class Admin::SiteGroupsController < ApplicationController
  before_action :redirect_unless_admin

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :set_site_group, only: [:show, :edit, :update, :destroy]
  
  def index
    @site_groups = SiteGroup.all.includes([:sites])
  end
  
  def new
    @site_group = SiteGroup.new
  end

  def create
    @site_group = SiteGroup.new(site_group_params)
    if @site_group.save
      redirect_to admin_site_groups_path
    else
      render 'new'
    end
  end

  def update
    @site_group.update(site_group_params)
    if @site_group.save
      redirect_to admin_site_groups_path
    else
      render 'edit'
    end
  end

  def show
    @sites = @site_group.sites
  end

  def destroy
    @site_group.destroy
    redirect_to admin_site_groups_path
  end


  private
  def set_site_group
    @site_group = SiteGroup.find(params[:id])
  end

  def site_group_params
    params.require(:site_group).permit(:name, :identifier)
  end
end
