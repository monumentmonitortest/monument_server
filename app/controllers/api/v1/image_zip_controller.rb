require 'zip'
module Api
  module V1
    class ImageZipController < BaseController
      #  TODO - work on this
      TMP_ARCHIVE_FOLDER_BASE = "tmp/archive_submissions".freeze
      
      def zip_images
        delete_current_tempfile
        SubmissionZipWorker.perform_async(permitted_params[:site_id], tmp_archive_dir)
        redirect_back(fallback_location: results_path)
      end

      # def download_zip
      #   if Dir.exists?(TMP_ARCHIVE_FOLDER)
      #     Rails.logger.info 'Zip file downloading'
      #     send_file(Rails.root.join("#{TMP_ARCHIVE_FOLDER}.zip"), :type => 'application/zip', :filename => "submissions.zip", :disposition => 'attachment')
      #   else
      #     Rails.logger.info "Zip folder not present, try again later"
      #   end
      # end
      private
      
      def site_id
        @site_id ||= permitted_params[:site_id]
      end

      def tmp_archive_dir
        # returns tmp/archive_submissions_6 for site ID 6
        "#{TMP_ARCHIVE_FOLDER_BASE}_#{site_id}"
      end

      def permitted_params
        params.permit(:site_id)
      end

      def delete_current_tempfile
        # delete both archive folder and contents
        if Dir.exists?(tmp_archive_dir)
          FileUtils.rm_rf(Dir["#{tmp_archive_dir}/*"]) 
          FileUtils.rm_rf(Dir["#{tmp_archive_dir}"]) 
        end
      end
    end
  end
end