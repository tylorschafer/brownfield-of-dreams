require 'rails_helper'

describe 'User dashboard' do
  describe 'Send an Invite' do
    before :each do
      @user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'Sends email inventations through github handle' do
      visit '/dashboard'

      click_on 'Send an Invite'

      expect(current_path).to eq('/invite')

      fill_in 'Github Handle', with: 'tylorschafer'

      click_on 'Send Invite'

      expect(current_path).to eq('/dashboard')

      expect(page).to have_content("Successfully sent invite!")
    end

    it "An error will display if github user does not have an email" do

      visit '/dashboard'
      click_on 'Send an Invite'
      fill_in 'Github Handle', with: 'sadpathtylor'
      click_on 'Send Invite'

      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end
end
