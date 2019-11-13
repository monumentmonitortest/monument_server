#A script to get the what percentage of work one off users contributed

t = Type.where(name: "WHATSAPP")
subs = {}

t.map do |type|
  tuser = type.data["number"]
  
  if subs[tuser].present?
    subs[tuser] << type.submission
  else
    subs[tuser] = []
    subs[tuser] << type.submission
  end
end

#subs...

#one_off contributions
one_offs = 0
more_than_one = []

subs.each do |user|
  dates = user[1].map(&:record_taken).uniq.count
  if dates == 1
    one_offs = one_offs + user[1].count
  elsif dates > 1
    more_than_one << user[0]
  end
end


puts "total contributions in Twitter type: #{t.count}"
puts "total contributions from one offs: #{one_offs}"
puts "percentage of one offs: #{(one_offs/t.count)*100}"