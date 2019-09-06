require 'open-uri'

class InstaBacklogJob
  def perform
    posts = File.read('./lib/monumentmonitor.json')
    post_json = JSON.parse(posts)
    post_json.each do |post|
        
      if post['shortcode_media']['edge_sidecar_to_children']
        images = post['shortcode_media']['edge_sidecar_to_children']['edges']

        images.each do |image|
          image_url = image['node']['display_url']
          type_specific_id = image['node']['id']
          create_submission(post, image_url, type_specific_id)
        end
      else
        image_url = post['shortcode_media']['display_url']
        type_specific_id = post['shortcode_media']['id']
        create_submission(post, image_url, type_specific_id)
      end
    end
  end

  private

  def create_submission(post, image, id)
    post_desc = post['shortcode_media']['edge_media_to_caption']['edges'][0]['node']['text']
    insta_user = post['shortcode_media']['owner']['username']
    taken = post['shortcode_media']['taken_at_timestamp']
    record_taken = DateTime.strptime(taken.to_s,'%s')

    type_specific_id = id
    image_url = image

    unless Type.find_by(type_specific_id: type_specific_id)
      registration = Registration.new(reliable: false, 
        site_id: site_id, 
        image_file: image_url, 
        comment: post_desc,
        record_taken: record_taken, 
        type_name: 'INSTAGRAM', 
        twitter_username: '',
        email_address: '',
        number: '',
        insta_username: insta_user, 
        type_specific_id: type_specific_id
      )
      
      if registration.save
        puts 'saved successffully'
      else
        puts "there was an error: #{registration.error}"
      end
    else
      puts "submission already exists"
    end
  end

  def site_id
    @site_id ||= Site.find_by(name: 'Instagram unsorted').id
  end
end