puts "starting exif script"
Submission.where(metadata: {}).each do |sub|
  image = MiniMagick::Image.open(sub.image.attachment.service_url)
  sub.metadata['width'] = image.width
  sub.metadata['height'] = image.height
  sub.metadata['size'] = image.size
  sub.metadata['resolution'] = image.resolution
  sub.metadata['make'] = image.exif["Make"]
  sub.metadata['model'] = image.exif["Model"]
  sub.save
  puts "submission updated"
  puts sub.metadata
end