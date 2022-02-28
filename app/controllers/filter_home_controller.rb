# frozen_string_literal: true

class FilterHomeController < ApplicationController
  layout "filter_home"

  def index
    @site_name = site_name
    @site_names = Site.all.map {|s| s.name }
    @tags = ActsAsTaggableOn::Tag.all.map {|t| t.name}.uniq 
    @user_email = current_user.try(:email) || ""
  end

  private

  def site_name
    permitted_params[:site_id].present? ? Site.find(permitted_params[:site_id]).name : ""
    
  rescue ActiveRecord::RecordNotFound
    ""
  end

  def permitted_params
    params.permit(:site_id) 
  end
end
