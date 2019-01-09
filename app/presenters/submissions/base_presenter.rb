module Submissions
  class BasePresenter < ::BasePresenter

    def url
      h.site_submissions_path
    end 
  end
end