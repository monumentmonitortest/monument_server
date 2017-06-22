image_urls = Image.select([:url]).group(:url).having("count(url) > 1").all.size
image_url_array = image_urls.to_a
deleted_images = 0
image_url_array.each do |array|
  url = array.first
  same_images = Image.where(url: url).sort_by &:created_at
  same_images.each_with_index do |image, i|
    if i > 0
      image.delete
      deleted_images += 1
    end
  end
end

puts "#{deleted_images} images deleted"
