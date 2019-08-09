# frozen_string_literal: true

class FilterHomeController < ApplicationController
  layout "filter_home"

  def index
    @site_names = Site.all.map {|s| s.name }
  end
end
