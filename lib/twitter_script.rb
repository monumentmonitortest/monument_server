puts "Starting Twitter script"
count = Image.count
TwitterJob.new.perform
new_count = Image.count

new = new_count - count
puts "DONE! Lets hope it worked, #{new} images created"
