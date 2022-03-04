class ZipMailer < ApplicationMailer

  default from: 'notifications@example.com'
 
  def job_done(email:, url: )
    @email = email
    @url  = url
    mail(to: @email, subject: 'Your download is ready')
  end
end
