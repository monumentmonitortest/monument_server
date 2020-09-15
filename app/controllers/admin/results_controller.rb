class Admin::ResultsController < ApplicationController

  def index
    @type_numbers = create_type_numbers_array
    # @site_numbers = create_site_numbers
  end
  


  private

  def create_type_numbers_array
    Submission::TYPE_NAMES.map do |name|
      Submission.where(type_name: name ).count
    end
  end

  def create_site_numbers
    Site.all.map do |site|
      {
        name: site.name, 
        submissions: site.submissions.count,
        twitter: site.submissions.where(type_name: "TWITTER" ).count,
        instagram: site.submissions.where(type_name: "INSTAGRAM" ).count,
        email: site.submissions.where(type_name: "EMAIL").count,
        whatsapp: site.submissions.where(type_name: "WHATSAPP").count
      }
    end
  end
end
