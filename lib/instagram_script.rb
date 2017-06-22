puts "Starting Instagram script"
count = Image.count
InstaJob.new.perform
new_count = Image.count
new = new_count - count
puts "DONE! Lets hope it worked, #{new} images created"
