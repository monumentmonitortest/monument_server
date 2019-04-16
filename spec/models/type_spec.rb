require 'rails_helper'
RSpec.describe Type, type: :model do
  
  context 'associations' do
    it { should belong_to(:submission) }
  end 
end