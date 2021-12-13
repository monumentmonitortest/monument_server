
#### new script...

TYPE_NAME = 'ALL'
subs = Submission.all
count = subs.count
participants = subs.map(&:participant_id).uniq
pcount = participants.count

# number of people who submitted only once
one_offs = subs.select(:type_name,:participant_id).group(:type_name,:participant_id).having("count(*) < 2").size.count

# array of number of submissions per participant
array = subs.select(:participant_id).group(:participant_id).size.values
# average number of submissions
av = array.sum(0.0)/array.size

puts "total submissions in #{TYPE_NAME} type: #{count}"
puts "total participants in #{TYPE_NAME} type: #{pcount}"
puts "total contributions from one offs: #{one_offs}"
puts "percentage of one offs: #{(one_offs.to_f/count.to_f)*100}"
puts "Average submissions: #{av}"