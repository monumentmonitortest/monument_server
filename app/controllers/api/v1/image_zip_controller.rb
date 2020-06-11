require 'zip'
module Api
  module V1
    # TODO - tests and DRY UP
    class ImageZipController < BaseController
      
      def zip_images
        delete_current_tempfile

        SubmissionZipWorker.perform_async(permitted_params[:site_id])

        redirect_back(fallback_location: results_path)
      end

      def download_zip
        tmp_user_folder = "tmp/archive_submissions"
        send_file(Rails.root.join("#{tmp_user_folder}.zip"), :type => 'application/zip', :filename => "Files_for_submissions.zip", :disposition => 'attachment')
      end

      private

      def permitted_params
        params.permit(:site_id)
      end

      def delete_current_tempfile
        tmp_user_folder = "tmp/archive_submissions"

        if Dir.exists?(tmp_user_folder)
          FileUtils.rm_rf(Dir["#{tmp_user_folder}/*"]) 
        end
      end
    end
  end
end