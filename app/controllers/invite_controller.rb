class InviteController < ApplicationController

  def new
  end

  def create
    service = GithubService.new(ENV['GITHUB_USER_TOKEN'])
    result = service.get_email(params['Github Handle'])
    email = result[0][:payload][:commits][0][:author][:email]
    InviteMailer.invite_send(email, params['Github Handle'], current_user.first_name).deliver_now
    redirect_to '/dashboard'
  end
end
