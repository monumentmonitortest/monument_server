name = "WHATSAPP"
subs = Submission.joins(:type).where(types: { name: name }).where("record_taken > ?", DATE)
subs.map {|s| s.type.data["number"]}.uniq.count


Submission.where.not(site_id: 26).where("record_taken > ?", DATE).joins(:type).where(types: { name: name }).count
                    .where.not(site_id: 26).count