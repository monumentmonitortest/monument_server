participants = Participant.all

participants.each do |p|
	begin
	first_submission = p.submissions.first
	date = first_submission.submitted_at || first_submission.record_taken
	p.first_submission = date
	p.save
	rescue
		binding.pry
		puts "something went wrong here"
	end
end

puts 'finished'