submissions = Submission.all

submissions.each do |sub|
	# Add type information to submission
	begin
		type = sub.type
		sub.type_name = type.name
		sub.comment = type.comment
		sub.type_specific_id = type.type_specific_id
		# save submission
		
		
		# get participant ID
		if type.name == "TWITTER"
			p_id = type.data["twitter_username"]
		elsif type.name == "EMAIL"
			p_id = type.data["email_address"]
		elsif type.name == "WHATSAPP"
			p_id = type.data["number"]
		elsif type.name == "INSTAGRAM"
			p_id = type.data["insta_username"]
		else
			binding.pry
		end

		participant = Participant.find_by(participant_id: p_id)

		if participant.nil?
			new_participant = Participant.create!(participant_id: p_id)
			sub.participant_id = new_participant.id
			puts "created new participant!"
		else
			sub.participant_id = participant.id
			puts "didn't"
		end
		sub.save
		puts "sub saved"
	rescue
		puts "something went wrong"
	end
end