require 'rails_helper'

describe 'User Can Have Friends' do
  before :each do
    @josh = create(:user, gh_token: 'asdfasdfasdf')
    @diane = GithubUser.new({login: "Diane", html_url: "", avatar_url: "https://www.esds.co.in/blog/wp-content/uploads/2018/05/Mannual-Testing.jpg", email: "email@email.com"} )
    @dianes_account = create(:user, handle: "Diane")
    @mike = GithubUser.new({login: "Mike", html_url: "https://www.esds.co.in/blog/wp-content/uploads/2018/05/Mannual-Testing.jpg", avatar_url: "", email: "email3@email.com"} )
    @repo = Repo.new({ name: 'Tylors Project', html_url: 'https://www.google.com'})

    allow_any_instance_of(UserShowFacade).to receive(:followers).and_return([@diane, @mike])
    allow_any_instance_of(UserShowFacade).to receive(:following).and_return([@diane, @mike])
    allow_any_instance_of(UserShowFacade).to receive(:repos).and_return([@repo])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@josh)

    visit dashboard_path
  end

  it "When I login and go to " do

    within ".followers" do
      expect(page).to have_content(@diane.name)

      within "#gh_user-#{@mike.name}" do
        expect(page).to_not have_link("Add as Friend")
      end

      within "#gh_user-#{@diane.name}" do
        expect(page).to have_link("Add as Friend")

        click_on "Add as Friend"
      end
    end

    expect(page).to have_css(".friends")

    within ".friends" do
      expect(page).to have_content(@dianes_account.first_name)
    end

  end

  it 'an error will display if a bad user_id is passed' do
    allow_any_instance_of(Users::FriendshipsController)
    .to receive(:create_friendship)
    .and_return(Friendship.create(user_id: 1, friend_id: 1000))

    within ".followers" do
      within "#gh_user-#{@diane.name}" do
        expect(page).to have_link("Add as Friend")

        click_on "Add as Friend"
      end
    end

    expect(page).to have_content("Friend must exist")
  end
end
