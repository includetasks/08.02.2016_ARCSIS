require 'rails_helper'

RSpec.describe User, type: :model do
  let(:spec_user) { create(:user) }
  let(:spec_another_user) { create(:user) }

  context 'is valid when' do
    it 'all fields has allowable values' do
      expect(spec_user).to be_valid
    end
  end

  context 'is invalid when' do
    it '#email is not present' do
      spec_user.email = ''
      expect(spec_user).not_to be_valid
    end

    it '#email is not uniqueness' do
      spec_another_user.email = spec_user.email
      expect(spec_another_user).not_to be_valid
    end
    
    it '#first_name is not present' do
      spec_user.first_name = ''
      expect(spec_user).not_to be_valid
    end

    it '#last_name is not present' do
      spec_user.last_name = ''
      expect(spec_user).not_to be_valid
    end

    it '#phone is not present' do
      spec_user.phone = ''
      expect(spec_user).not_to be_valid
    end
  end
end
