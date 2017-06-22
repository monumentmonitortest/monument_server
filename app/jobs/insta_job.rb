require 'insta_scrape'

class InstaJob

  def perform
    scrape_result = InstaScrape.hashtag('monumentMonitor')
    # scrape_result = InstaScrape.long_scrape_hashtag('monumentMonitor', 10, include_meta_data: true)

    scrape_result.each do |post|
      if !Image.where(["source = ?", "instagram"]).find_by(url: post.image)
        create_image(post)
      end
    end
  end

  private

  def create_image(post)
    if post.username.nil?
      user_id = nil
    else
       user_id = create_user(post.username).id
    end
    Image.new(
      url: post.image,
      date_taken: post.date,
      source: "instagram",
      insta_user_id: user_id
    ).save
  end

  def create_user(username)
    user = find_user(name)
    new_user = Instuser.new(
      user_name: user.username,
      followers_count: user.follower_count,
      friends_count: user.friends_count,
      post_count: user.post_count
    ).save
    new_user
  end

  def find_user(name)
    InstaScrape.user_info(name)
  end
end
