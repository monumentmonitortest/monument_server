class SubmissionsDataCreateService
  def initialize(submissions, date)
    @submissions = submissions
    @date = date
  end

  def create
    by_month_object = submissions_data_hash(@submissions, @date)

    { byMonth: by_month_object, tags: tags_object, types: types_object }
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
      Type.select(:name).group(:name).size.map {|name,number| {x: name, y: number}}

    end

    def tags_object
      tags = @submissions.select(:tags).map { |t| t[:tags].keys }.flatten

      # get all the tags and their values
      tags = @submissions.select(:tags).map { |t| t[:tags] }.flatten
      # create new hash
      new = Hash.new
      # flatten them down into one object
      tags.each do |hash| 
        hash.map do |text, value| 
          if new[text]
            new[text][:count] += 1
            new[text][:value] << value.round(2)
          else
            new[text] = {count: 1, value: [value.round(2)]}
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
end
