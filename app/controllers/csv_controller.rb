class CsvController < ApplicationController
  before_action :redirect_unless_admin

  def index
  end

  def create
    file = params["CSV-file"].read
    data = JSON.parse(file)
    import_instagram(data)
    redirect_to '/admin'
  end

  private
  
  def import_instagram(data)
    data.each do |submission|
      Type.find_by(type_specific_id: submission["imageUrl"]) ? "" : create_registration(submission)
    end
  end

  def instagram_site_id
    Site.find_by(name: 'Instagram unsorted').id
  end

  def create_registration(hash)
    registration = Registration.new(reliable: false,
                                    site_id: instagram_site_id,
                                    image_file: hash["imageUrl"],
                                    record_taken: hash["timestamp"],
                                    type_name: "INSTAGRAM",
                                    email_address: "",
                                    number: "",
                                    insta_username: hash["url"],
                                    twitter_username: "",
                                    type_specific_id: hash["imageUrl"],
                                    comment: hash["firstComment"])

    if registration.save
      puts "registration save succesfull"
    else
      binding.pry
      puts "whoops, there's been an error:"
    end
  end
end