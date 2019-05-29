FactoryBot.define do
  factory :attachment do
    item { File.new(Rails.root + 'spec/support/assets/test-image.jpg') } 
  end
end