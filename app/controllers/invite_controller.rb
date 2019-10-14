class InviteController < ApplicationController

  def new
  end

  def create
    service = GithubService.new(ENV['GITHUB_USER_TOKEN'])
    result = service.get_email(params['Github Handle'])
    email = result[0][:payload][:commits][0][:author][:email]
    if email
      InviteMailer.invite_send(email, params['Github Handle'], current_user.first_name).deliver_now
      flash[:success] = "Successfully sent invite!"
      redirect_to '/dashboard'
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
  end
end
