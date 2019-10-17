require "rails_helper"

RSpec.describe ActivationMailer, type: :mailer do
  describe 'activation' do
    before :each do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      @sent_mail = ActivationMailer.activate(@user).deliver_now
    end

    it 'renders the correct subject' do
      expect(@sent_mail.subject).to eq('Activate your account')
    end

    it 'renders the correct reciver email' do
      expect(@sent_mail.to).to eq([@user.email])
    end

    it 'renders the correct sender email' do
      expect(@sent_mail.from).to eq(['noreply@tylorandkellysapp.com'])
    end
  end
end
