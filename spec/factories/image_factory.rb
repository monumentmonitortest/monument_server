FactoryBot.define do
  factory :image do
    url { "www.image.com" }
    site { 'MACHRIE' }
    source  { "UNDEFINED" }
    reliable { false }
  end
end