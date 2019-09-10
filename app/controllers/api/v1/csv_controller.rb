module Api
  module V1
    # note, this inherites from action controller not base controller as is not exact API
    class CsvController < ActionController::Base

      def type_specific
        # returns report with breakdown of individuals submissions
        respond_to do |format|
          format.csv { send_data create_specific_type_report(params[:type_name]), filename: "user-specific-submissions-#{Date.today}.csv"  }
        end
      end

      def basic_submission
        # returns basic report with all submissions
        respond_to do |format|
          format.csv { send_data create_basic_submissions_report, filename: "basic-submissions-#{Date.today}.csv"  }
        end
      end


      private

        def create_basic_submissions_report
          attributes = %w{submission-id site-name record-taken type-name}
          CSV.generate(headers: true) do |csv|
            csv << attributes

            Submission.all.each do |submission|
              row = [submission.id, submission.site.name, submission.record_taken, submission.type.name]
              csv << row
            end
          end
        end


        # creates report on specific type
        def create_specific_type_report(name)
          attributes = %w{user-id submission-numbers records-taken}
          CSV.generate(headers: true) do |csv|
            csv << attributes

            users = Type.where(name: name).map { |t| t.data['insta_username']}.uniq
            users.map do |user| 
              submissions = Type.where('data @> ?', {insta_username: user}.to_json)
              row = [user, submissions.count]
              row = row + submissions.map {|s| s.submission.record_taken}.uniq.flatten
              csv << row
            end
          end
        end


    end
  end
end