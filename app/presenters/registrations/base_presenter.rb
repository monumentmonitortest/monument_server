module Registrations
  class BasePresenter < ::BasePresenter

    def url
      h.site_registrations_path
    end 
  end
end