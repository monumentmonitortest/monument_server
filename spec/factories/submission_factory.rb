FactoryBot.define do
  factory :submission do
    site_id { create(:site).id}
    record_taken { Date.today }
    tags  { {} }
  end
end