require 'rails_helper'
RSpec.describe Type, type: :model do
  
  context 'associations' do
    it { should have_many(:submissions) }
  end 
end