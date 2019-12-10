class SubmissionsDataCreateService
  def initialize(submissions, date)
    @submissions = submissions
    @date = date
  end

  def create
    by_month_object = submissions_data_hash(@submissions, @date)

   
    # binding.pry
    # types = types_data_hash
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
      tags_hash = Hash.new(0)
      tags.each {|t| tags_hash[t] += 1}
      tags_hash.sort_by {|_key, value| value}.map {|k,v| {text: k, value: v}}.last(100)
    end
end
