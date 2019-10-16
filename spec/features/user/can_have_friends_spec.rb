# Details: We want to create friendships between users with accounts in our database.
#  Long term we want to make video recommendations based on what friends are bookmarking.
#   This card should not include the recommendation logic. That's coming in a different user story.
#
# Background: A user (Josh) exists in the system with a Github token. The user has
#  two followers on Github. One follower (Dione) also has an account within our database.
#   The other follower (Mike) does not have an account in our system. If a follower
#   or following has an account in our system we want to include a link next to
#   their name to allow us to add as a friend.
#
# In this case Dione would have an Add as Friend link next to her name.
#   Mike would not have the link next to his name.
#
# Tips: No need to work on edge cases during your spike.
#  You'll want to research self referential has_many through.
#  Here's a good starting point to understand the c
#  oncept: http://blog.hasmanythrough.com/2007/10/30/self-referential-has-many-through.
#   You'll probably need to do more googling but that's part of the fun ;)
#
#  Links show up next to followers that have accounts in our system.
          # Reference follower handles with user names in the db


#  Links show up next to followings that have accounts in our database.
#  Links do not show up next to followers or followings if they are not in our database.


#  There's a section on the dashboard that shows all of the users that I have friended
#  Edge Case: Make sure this fails gracefully. If you open up a POST route to create a
#  friendship, be sure to catch the scenario where someone sends an invalid user id.
#  Send a flash message alerting them of the error.


require 'rails_helper'

describe 'User Can Have Friends' do
  it "When I login and go to " do
    josh = create(:user, gh_token: 'asdfasdfasdf')
    diane = GithubUser.new({login: "Diane", html_url: "", avatar_url: "https://www.esds.co.in/blog/wp-content/uploads/2018/05/Mannual-Testing.jpg", email: "email@email.com"} )
    dianes_account = create(:user, handle: "Diane")
    mike = GithubUser.new({login: "Mike", html_url: "https://www.esds.co.in/blog/wp-content/uploads/2018/05/Mannual-Testing.jpg", avatar_url: "", email: "email3@email.com"} )
    repo = Repo.new({ name: 'Tylors Project', html_url: 'https://www.google.com'})

    allow_any_instance_of(UserShowFacade).to receive(:followers).and_return([diane, mike])
    allow_any_instance_of(UserShowFacade).to receive(:following).and_return([diane, mike])
    allow_any_instance_of(UserShowFacade).to receive(:repos).and_return([repo])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(josh)

    visit dashboard_path

    within ".followers" do
      expect(page).to have_content(diane.name)

      within "#gh_user-#{mike.name}" do
        expect(page).to_not have_link("Add as Friend")
      end

      within "#gh_user-#{diane.name}" do
        expect(page).to have_link("Add as Friend")

        click_on "Add as Friend"
      end
    end

    expect(page).to have_css(".friends")

    within ".friends" do
      expect(page).to have_content(dianes_account.first_name)
    end
  end
end
