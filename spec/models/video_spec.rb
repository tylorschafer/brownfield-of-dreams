require 'rails_helper'

describe Video do
  describe 'Validations' do
    it {should validate_numericality_of :position}
  end

  describe 'Relationships' do
    it {should have_many :user_videos}
    it {should have_many(:users).through(:user_videos)}
    it {should belong_to :tutorial}
  end
end
