# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:password) }
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name: 'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name: 'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'Instance methods' do
    it '#bookmarks_by_tutorial will return all user_videos grouped by tutorail' do
      user = create(:user)
      tutorial = create(:tutorial)
      tutorial_2 = create(:tutorial)
      v1 = create(:video, tutorial: tutorial, position: 1)
      v2 = create(:video, tutorial: tutorial, position: 0)
      v3 = create(:video, tutorial: tutorial_2)
      user.user_videos.create(user_id: user.id, video_id: v1.id)
      user.user_videos.create(user_id: user.id, video_id: v2.id)
      user.user_videos.create(user_id: user.id, video_id: v3.id)

      expect(user.bookmarks_by_tutorial[0].title).to eq(tutorial.title)
      expect(user.bookmarks_by_tutorial[0].videos[0].title).to eq(v2.title)
      expect(user.bookmarks_by_tutorial[0].videos[1].title).to eq(v1.title)
      expect(user.bookmarks_by_tutorial[1].title).to eq(tutorial_2.title)
      expect(user.bookmarks_by_tutorial[1].videos[0].title).to eq(v3.title)
    end

    it '#is_friend? finds if user has this friend' do
      friend = create(:user, handle: 'megan')
      user = create(:user)
      user.friends << friend

      expect(user.has_friend?('megan')).to be_truthy
    end
  end

  describe 'Class methods' do
    it 'in_system? can find a user in the database with through github handle' do
      diane = GithubUser.new({login: "Diane", html_url: "", avatar_url: "https://www.esds.co.in/blog/wp-content/uploads/2018/05/Mannual-Testing.jpg", email: "email@email.com"} )
      dianes_account = create(:user, handle: "Diane")

      expect(User.in_system?(diane.name)).to eq(dianes_account)
    end
  end
end
