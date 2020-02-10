FactoryBot.define do
  factory :submission do
    site_id { create(:site).id}
    record_taken { Date.today }
    ai_tags  { {} }
    image { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test-image.jpg'), 'image/jpg') }

    factory :submission_with_type do
      type { Type.new(name: "EMAIL", data: { email_address: "thing@thing.com" }) }
    end

    factory :submission_with_insta_type do
      type { Type.new(name: "INSTAGRAM", data: { insta_username: "blob" }) }
    end
  end
end