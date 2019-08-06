module Api
  module V1
    class SubmissionsController < BaseController

      def index
        submissions_scope ||= reliable? ? Submission.all.reliable : Submission.all
        submissions_scope ||= search_site(submissions_scope, site_filter) if site_filter?
        submissions_scope ||= type_search(submissions_scope, type_filter) if type_filter?

        paginate json: submissions_scope, per_page: page_size
      end

      private

        def permitted_params
          params.permit(:reliable, 
                        :site_id,
                        :site_name,
                        :type_name,
                        :bespoke_size,
                        :page)
        end

        def page_size
          params[:bespoke_size] || (params[:page] && params[:page][:size]) || 2
        end

        def reliable?
          permitted_params[:reliable] == "true"
        end

        def site_filter?
          site_filter.present?
        end

        def type_filter?
          type_filter.present?
        end

        def site_filter
          permitted_params[:site_filter]
        end

        def type_filter
          permitted_params[:site_filter]
        end

        def search_site(collection, name)
          collection.where(site_id: Site.find_by(name: name))
        end
        
        def type_search(collection, type_name)
          type_name.upcase!
          collection = collection.joins(:type).where(types: { name: type_name})
          collection
        end
    end
  end
end