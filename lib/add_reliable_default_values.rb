images = Image.where(reliable: nil)
images.each { |i| i.reliable = false; i.save }

puts "#{images.count} images updated"
