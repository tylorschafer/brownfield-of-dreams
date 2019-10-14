require 'rails_helper'

describe 'User dashboard' do
  describe 'Send an Invite' do
    before :each do
      # As a registered user
      @user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
    it 'Sends email inventations through github handle' do
      # When I visit /dashboard
      visit '/dashboard'
      # And I click "Send an Invite"
      click_on 'Send an Invite'
      # Then I should be on /invite
      expect(current_path).to eq('/invite')
      # And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
      fill_in 'Github Handle', with: 'tylorschafer'
      # And I click on "Send Invite"
      click_on 'Send Invite'
      # Then I should be on /dashboard
      expect(current_path).to eq('/dashboard')
      # And I should see a message that says "Successfully sent invite!" (if the user has an email address associated with their github account)
      expect(page).to have_content("Successfully sent invite!")
    end
    it "An error will display if github user does not have an email" do
      # Or I should see a message that says "The Github user you selected doesn't have an email address associated with their account."

      visit '/dashboard'
      click_on 'Send an Invite'
      fill_in 'Github Handle', with: 'sadpathtylor'
      click_on 'Send Invite'

      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end
end
