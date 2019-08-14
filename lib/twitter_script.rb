puts "Starting Twitter script"
count = Submission.count
TwitterJob.new.perform
new_count = Submission.count

new = new_count - count
puts "DONE! Lets hope it worked, #{new} submissions created"
