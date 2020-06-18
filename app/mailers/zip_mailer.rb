class ZipMailer < ApplicationMailer

  default from: 'notifications@example.com'
 
  def job_done(email: email, url: url)
    @email = email
    @url  = url
    mail(to: @email, subject: 'Your Zip job is ready')
  end
end
