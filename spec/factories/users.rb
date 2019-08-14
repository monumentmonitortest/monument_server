FactoryBot.define do
  factory :user do
    email { 'email@thing.com' }
    password { 'secure' }
    admin { true }
  end
end
