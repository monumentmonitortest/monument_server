require 'zip'
module Api
  module V1
    class ImageZipController < BaseController
      TMP_ARCHIVE_FOLDER = "tmp/archive_submissions"
     
      def zip_images
        delete_current_tempfile

        SubmissionZipWorker.perform_async(permitted_params[:site_id])

        redirect_back(fallback_location: results_path)
      end

      def download_zip
        if Dir.exists?(TMP_ARCHIVE_FOLDER)
          Rails.logger.info 'Zip file downloading'
          send_file(Rails.root.join("#{TMP_ARCHIVE_FOLDER}.zip"), :type => 'application/zip', :filename => "submissions.zip", :disposition => 'attachment')
        else
          Rails.logger.info "Zip folder not present, try again later"
        end
      end

      private

      def permitted_params
        params.permit(:site_id)
      end

      def delete_current_tempfile
        # delete both archive folder and contents
        if Dir.exists?(TMP_ARCHIVE_FOLDER)
          FileUtils.rm_rf(Dir["#{TMP_ARCHIVE_FOLDER}/*"]) 
          FileUtils.rm_rf(Dir["#{TMP_ARCHIVE_FOLDER}"]) 
        end
      end
    end
  end
end