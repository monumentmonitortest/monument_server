module Api
  module V1
    class SubmissionsController < BaseController

      # TODO - this is the same as the normal frontend, thus is should be dried up rather
      def index
        submissions_scope = Submission.all

        submissions_scope = submissions_scope.reliable if params[:reliable] == "true"
        submissions_scope = search_site(submissions_scope, params[:site_filter]) if params[:site_filter].present?
        submissions_scope = type_search(submissions_scope, params[:type_filter]) if params[:type_filter].present?

        render json: submissions_scope
      end

      private

        def permitted_params
          params.require(:submission).permit(:reliable, 
                                            :site_id,
                                            :site_name,
                                            :type_name)
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