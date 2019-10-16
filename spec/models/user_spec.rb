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

  describe 'Class methods' do
    it 'in_system? can find a user in the database with through github handle' do
      diane = GithubUser.new({login: "Diane", html_url: "", avatar_url: "https://www.esds.co.in/blog/wp-content/uploads/2018/05/Mannual-Testing.jpg", email: "email@email.com"} )
      dianes_account = create(:user, handle: "Diane")

      expect(User.in_system?(diane.name)).to eq(dianes_account)
    end
  end
end
