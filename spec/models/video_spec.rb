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

  describe 'class methods' do
    it 'not_positioned returns all videos that have nil position values' do
      v1 = create(:video)
      v2 = create(:video)
      v3 = create(:video)

      expect(Video.not_positioned).to eq([])
    end
  end

  describe 'instance methods' do
    it '#return_used_placements returns all placements other videos in the tutorial are using' do
      tutorial = create(:tutorial)
      v1 = create(:video, tutorial: tutorial, position: 1)
      v2 = create(:video, tutorial: tutorial, position: 0)
      v3 = create(:video, tutorial: tutorial, position: 4)

      expect(v3.return_used_placements).to eq([0, 1])
    end

    it '#update_placement updates a videos placement to the next consecutive number' do
      tutorial = create(:tutorial)
      v1 = create(:video, tutorial: tutorial, position: 1)
      v2 = create(:video, tutorial: tutorial, position: 0)
      v3 = create(:video, tutorial: tutorial, position: 4)

      v3.update_placement

      expect(v3.position).to eq(2)
    end
  end
end
