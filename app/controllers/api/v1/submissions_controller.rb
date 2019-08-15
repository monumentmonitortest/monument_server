module Api
  module V1
    class SubmissionsController < BaseController

      def index
        submissions_scope ||= reliable? ? scope.reliable : scope

        unsorted_sites.each do |id|
          submissions_scope = submissions_scope.exclude_unsorted(id)
        end

        paginate json: submissions_scope.order(record_taken: :desc), per_page: page_size
      end

      private

        def scope
          Submission.with_attached_image.search_site(site_filter).type_search(type_filter)
        end

        def permitted_params
          params.permit(:reliable, 
                        :site_id,
                        :site_filter,
                        :type_filter,
                        :bespoke_size,
                        :page)
        end

        def page_size
          params[:bespoke_size] || (params[:page] && params[:page][:size]) || 10
        end

        def reliable?
          permitted_params[:reliable] == "true"
        end

        def site_filter
          permitted_params[:site_filter]
        end

        def type_filter
          permitted_params[:type_filter]
        end

        def unsorted_sites
          @unsorted_sites||= Site::UNSORTED_SITES.map {|name| Site.find_by(name: name).try(:id) }
        end
    end
  end
end