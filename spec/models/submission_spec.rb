require 'rails_helper'
RSpec.describe Submission, type: :model do
  
  context 'associations' do
    it { should belong_to(:site) }
    it { should have_one(:type) }
  end 
end
