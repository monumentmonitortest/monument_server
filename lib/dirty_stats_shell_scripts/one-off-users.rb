
#### new script...

TYPE_NAME = 'ALL'
date = '01/06/2021'.to_date
subs = Submission.where("submitted_at < ?", date)
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



subs = Submission.where("submitted_at < ?", date).where(type_name: "TWITTER")
ps = subs.all.map {|s| s.participant}
hash = ps.map { |p| {p.id => p.submissions.count} }
hash.uniq.map {|v| v.values}.flatten


ps = Participant.where("created_at < ?", date) #1703