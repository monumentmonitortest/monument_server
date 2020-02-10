class SubmissionsDataCreateService
  def initialize(submissions, date)
    @submissions = submissions
    @date = date
  end

  def create
    by_month_object = submissions_data_hash(@submissions, @date)

    { 
      byMonth: by_month_object, 
      ai_tags: ai_tags_object, 
      types: types_object, 
      maxSubs: top_scores_object, 
      minSubs: bottom_scores_object,
    }
  end

  private
  
    def submissions_data_hash(submissions, date)
      date_hash = Hash[(0..12).collect { |n| [ date.advance(months: n).strftime('%m/%y') , 0 ] }]
      submissions_by_month = submissions.group("TO_CHAR(record_taken, 'MM/YY')").count.sort
      
      date_hash.map do |k,v| 
        {x: k, y: submissions_by_month.to_h[k] ? submissions_by_month.to_h[k] : 0 }
      end
    end

    def types_object
      Type.select(:name).group(:name).size.map {|name,number| {x: name.capitalize, y: number}}
    end

    def ai_tags_object
      # get all the tags and their values
      # binding.pry
      tags = @submissions.select(:ai_tags).map { |t| t[:ai_tags] }.flatten
      # create new hash
      new = Hash.new
      # flatten them down into one object

      tags.each do |hash| 
        # Hacky hack - due to incorrect migration - needs to be sorted!!
       unless hash == "{}"
          puts hash
          hash.map do |text, value| 
            if new[text]
              new[text][:count] += 1
              new[text][:value] << value.round(2)
            else
              new[text] = {count: 1, value: [value.round(2)]}
            end
          end
        end
      end

      # get the mean score for certaintly
      new.map do |label| 
        array = label[1][:value]
        mean = array.inject{ |sum, el| sum + el }.to_f / array.size
        label[1][:value] = mean.round(2)
      end


      # make it into another new object, coz why on earth not...
      final = Array.new
      new.map {|label| final << { label: label[0], x: label[1][:value], y: label[1][:count]  } }
      # return the final array
      #I KNOW THIS IS AWFUL BUT I HAVE A DEADLINE. DON'T JUDGE ME!
      # sort them and get the last 100
      final.sort_by {|obj| obj[:y]}.last(70)
    end

    def top_scores_object
      scores.first(4).map(&:site).map(&:name)
    end

    def bottom_scores_object
      scores.last(4).map(&:site).map(&:name)
    end

    def scores
      @scores ||= Submission.select(:site_id).group(:site_id).order("count(site_id) desc")
    end
end
