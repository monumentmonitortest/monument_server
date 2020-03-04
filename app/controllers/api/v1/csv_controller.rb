# TODO - rename this reports controller or something
module Api
  module V1
    # note, this inherites from action controller not base controller as is not exact API
    class CsvController < ActionController::Base

      def type_specific
        # returns report with breakdown of individuals submissions
        respond_to do |format|
          format.csv { send_data create_specific_type_report(params[:type_name], params[:data]), filename: "user-specific-submissions-#{Date.today}.csv"  }
        end
      end

      def basic_submission
        # returns basic report with all submissions
        respond_to do |format|
          format.csv { send_data create_basic_submissions_report, filename: "basic-submissions-#{Date.today}.csv"  }
        end
      end

      def site_specific
        return unless params[:site_id].present?
        name = Site.find(params[:site_id]).name

        respond_to do |format|
          format.csv { send_data create_specific_site_report(params[:site_id], params[:from_date], params[:to_date]), filename: "submissions-for-#{name}-tags-#{Date.today}.csv"  }
        end
      end

      def site_specific_tags
        return unless params[:site_id].present?
        name = Site.find(params[:site_id]).name
        respond_to do |format|
          format.csv { send_data create_specific_site_tag_report(params[:site_id], params[:from_date], params[:to_date]), filename: "submissions-for-#{name}-#{Date.today}.csv"  }
        end
      end
      
      def tags_report
        return unless params[:site_id].present? || params[:tag].present?
        site = params[:site_id] ? "" : Site.find(params[:site_id])

        respond_to do |format|
          format.csv { send_data create_tags_report(site, params[:tag]), filename: "tag-report-#{params["tag"]}-#{site}#{Date.today}.csv"  }
        end
      end


      def image_quality
        respond_to do |format|
          format.csv { send_data create_image_quality_report(params[:type_name]), filename: "image-quality-#{params[:type_name].downcase}-#{Date.today}.csv"  }
        end
      end

      private

        def create_basic_submissions_report
          attributes = %w{submission-id site-name record-taken type-name}
          CSV.generate(headers: true) do |csv|
            csv << attributes

            Submission.all.each do |submission|
              row = [submission.id, submission.site.name, submission.record_taken.strftime("%d/%m/%Y"), submission.type.name]
              csv << row
            end
          end
        end


        # creates report on specific type
        def create_specific_type_report(name, data)
          attributes = %w{user-id submission-numbers records-taken}
          CSV.generate(headers: true) do |csv|
            csv << attributes

            users = Type.where(name: name).map { |t| t.data[data]}.uniq
            users.map do |user| 
              submissions = Type.where('data @> ?', {data => user}.to_json)
              row = [user, submissions.count]
              row = row + submissions.map {|s| s.submission.record_taken.strftime("%d/%m/%Y")}.uniq.flatten
              csv << row
            end
          end
        end

        # Normal
        def create_specific_site_report(site_id, from_date, to_date)
          attributes = %w{date submissions ind-submitters}
          CSV.generate(headers: true) do |csv|
            csv << attributes
            
            submissions_hash = {}
            submissions = Submission.
                            where(site_id: site_id).
                            where("record_taken >= :start_date AND created_at <= :end_date",
                               {start_date: Date.today- 1.year, end_date: Date.today}).
                            order(:record_taken)
            
             
            (from_date.to_date).upto(to_date.to_date) do |date|
              subs = submissions.where(record_taken: date)
              total_subs = subs.count
              unique_submitters = subs.map {|q| q.type.data}.uniq.count
              
              csv << [date.strftime("%d/%m/%Y"), total_subs, unique_submitters]
            end
          end
        end

        # With tags
        def create_specific_site_tag_report(site_id, from_date, to_date)
          attributes = %w{date ai_tags tags}
          CSV.generate(headers: true) do |csv|
            csv << attributes
            
            submissions = Submission.
                            where(site_id: site_id).
                            where("record_taken >= :start_date AND created_at <= :end_date",
                               {start_date: from_date, end_date: to_date}).
                            order(:record_taken)
            
            submissions.each do |sub|
              info = [sub.record_taken.strftime("%d/%m/%Y")] + sub.tag_list
              csv << info
            end             
          end
        end

        # Just tag reports
        def create_tags_report(site, tag)
          attributes = %w{submission-id date url tag}

          if site.empty? && tag
            # get all the submissions from a with that tag
            submissions = Submission.all.tagged_with(tag)
          elsif site && tag
            submissions = site.submissions.tagged_with(tag)
          end

          CSV.generate(headers: true) do |csv|
            csv << attributes 
            submissions.each do |sub|
              # removes the tag searched on
              tag_list = sub.tag_list
              tag_list.delete(tag)
              csv << [sub.id, sub.record_taken.strftime("%d/%m/%Y"), sub.image_url] + tag_list
            end
          end
        end

        def create_image_quality_report(type_params)
          attributes = %w{submission-id width height size resolution make model}
          types = Type.where(name: type_params)
          CSV.generate(headers: true) do |csv|
            csv << attributes
            
            types.each do |type|
              sub = type.submission
              metadata = sub.metadata
              csv << [sub.id, metadata['width'], metadata['height'], metadata['size'], metadata['resolution'], metadata['make'], metadata['model']]
            end
            
          end
        end

    end
  end
end