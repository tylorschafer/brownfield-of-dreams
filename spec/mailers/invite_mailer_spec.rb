require "rails_helper"

RSpec.describe InviteMailer, type: :mailer do
  describe 'invitations' do
    before :each do
      @found_user = GithubUser.new({
          login: 'tylorschafer',
          html_url: 'https://www.github.com/users/tylorschafer',
          avatar_url: 'www.google.com/doggiepicture.jpg',
          email: 'fake@fakemail.com'
        })

      current_user = create(:user)
      @sender_name = "#{current_user.first_name} #{current_user.last_name}"
      @sent_mail = InviteMailer.invite_send(@found_user, @sender_name)
    end

    it 'renders the correct subject' do
      expect(@sent_mail.subject).to eq("#{@sender_name} has sent you an Invitation")
    end

    it 'renders the correct reciver email' do
      expect(@sent_mail.to).to eq([@found_user.email])
    end

    it 'renders the correct sender email' do
      expect(@sent_mail.from).to eq(['noreply@tylorandkellysapp.com'])
    end
  end
end
