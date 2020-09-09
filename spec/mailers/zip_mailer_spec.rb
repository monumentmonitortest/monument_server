require "rails_helper"

RSpec.describe ZipMailer, type: :mailer do
  describe "job done" do
    let(:input_email) { 'email@gmail.com'}
    let(:input_url)   { 'www.image.zip' }
    let(:mail)  { described_class.job_done(email: input_email, url: input_url).deliver_now }

    it "renders the headers" do
      expect(mail.subject).to eq("Your Zip job is ready")
      expect(mail.to).to eq([input_email])
      expect(mail.from).to eq(["notifications@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include(input_url)
    end
  end
end
