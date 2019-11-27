require "google/cloud/vision"

puts "running tag job"
ImageTagJob.new.perform

