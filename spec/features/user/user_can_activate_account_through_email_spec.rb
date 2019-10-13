require 'rails_helper'

describe 'User Email Activation' do
  it 'user can activate account with email after registering' do
      email = 'jimbob@aol.com'
      first_name = 'Jim'
      last_name = 'Bob'
      password = 'password'
      password_confirmation = 'password'

      visit '/'

      click_on 'Sign In'

      click_on 'Sign up now.'

      fill_in 'user[email]', with: email
      fill_in 'user[first_name]', with: first_name
      fill_in 'user[last_name]', with: last_name
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password

      click_on'Create Account'

      expect(page).to have_content("This account has not yet been activated. Please check your email.")

      # after clicking on the activation link in the users email

      expect(current_path).to eq("/users/activation_true")
      
      expect(page).to have_content("Thank you! Your account is now activated.")

  end
end
