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

      def data
        date = Date.today - 1.year
        submissions ||= Submission.where('record_taken >= ?', date).search_site(site_filter)

        by_month_object = submissions_data_hash(submissions, date)

        
        tags = Submission.search_site(site_filter).select(:tags).map { |t| t[:tags].keys }.flatten
        types = Type.select(:name)

        render json: { byMonth: by_month_object, tags: tags, types: types }
      end

      private

        def scope
          Submission.with_attached_image.search_site(site_filter).type_search(type_filter)
        end

        def scope_without_images
          Submission.search_site(site_filter).type_search(type_filter)
        end

        def permitted_params
          params.permit(:reliable, 
                        :site_id,
                        :site_filter,
                        :type_filter,
                        :bespoke_size,
                        :page,
                        :pagination)
        end

        def page_size
          params[:bespoke_size] || (params[:page] && params[:page][:size]) || 10
        end

        def paginate?
          permitted_params[:pagination] == "true"
        end

        def reliable?
          permitted_params[:reliable] == "true"
        end

        def site_filter
          Site.find_by(name: permitted_params[:site_filter]).id if permitted_params[:site_filter].present?
        end

        def type_filter
          permitted_params[:type_filter]
        end

        def unsorted_sites
          @unsorted_sites||= Site::UNSORTED_SITES.map {|name| Site.find_by(name: name).try(:id) }
        end

        # todo - move this into a separate service probably, bit too much knowledge here
        def submissions_data_hash(submissions, date)
          date_hash = Hash[(0..12).collect { |n| [ date.advance(months: n).strftime('%m/%y') , 0 ] }]
          submissions_by_month = submissions.group("TO_CHAR(record_taken, 'MM/YY')").count.sort
          
          date_hash.map do |k,v| 
            {x: k, y: submissions_by_month.to_h[k] ? submissions_by_month.to_h[k] : 0 }
          end
        end
    end
  end
end