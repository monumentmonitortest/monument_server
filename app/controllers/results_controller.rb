class ResultsController < ApplicationController
  DATE = '01/09/2018'.to_date

  def index
    @type_numbers = create_type_numbers_array
    @site_numbers = create_site_numbers
  end
  


  private

  def create_type_numbers_array
    Type::NAMES.map do |name|
      Submission.joins(:type).where(types: { name: name }).where("record_taken > ?", DATE).count
    end
  end

  def create_site_numbers
    Site.all.map do |site|
      {
        name: site.name, 
        submissions: site.submissions.where("record_taken > ?", DATE).count,
        twitter: site.submissions.joins(:type).where(types: { name: "TWITTER" }).where("record_taken > ?", DATE).count,
        instagram: site.submissions.joins(:type).where(types: { name: "INSTAGRAM" }).where("record_taken > ?", DATE).count,
        email: site.submissions.joins(:type).where(types: { name: "EMAIK" }).where("record_taken > ?", DATE).count,
        whatsapp: site.submissions.joins(:type).where(types: { name: "WHATSAPP" }).where("record_taken > ?", DATE).count
      }
    end
  end
end
