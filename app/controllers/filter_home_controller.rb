# frozen_string_literal: true

class FilterHomeController < ApplicationController
  layout "filter_home"

  def index
    @site_names = Site.all.map {|s| s.name }
    @tags = ActsAsTaggableOn::Tag.all.map {|t| t.name}.uniq 
  end
end
