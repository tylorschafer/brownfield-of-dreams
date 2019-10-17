require 'rails_helper'

describe 'User Email Activation', :vcr do
  before :each do
    @email = 'jimbob@aol.com'
    @first_name = 'Jim'
    @last_name = 'Bob'
    @password = 'password'
    @password_confirmation = 'password'

    visit '/'

    click_on 'Sign In'

    click_on 'Sign up now.'

    fill_in 'user[email]', with: @email
    fill_in 'user[first_name]', with: @first_name
    fill_in 'user[last_name]', with: @last_name
    fill_in 'user[password]', with: @password
    fill_in 'user[password_confirmation]', with: @password

    click_on 'Create Account'

    @user = User.last
  end

  it 'user can activate account with email after registering' do

      expect(page).to have_content("This account has not yet been activated. Please check your email.")

      visit "/users/#{@user.token}/activation_true"

      expect(page).to have_content('Your account is now activated.')
  end

  it 'An activation link will not allow unauthenticated users to activate their account' do

    visit "/users/'faketoken'/activation_true"

    expect(page).to have_content('Sorry something went wrong.')
  end
end
