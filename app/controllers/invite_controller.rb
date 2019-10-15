class InviteController < ApplicationController

  def new
  end

  def create
    service = GithubService.new(ENV['GITHUB_USER_TOKEN'])
    result = service.get_email(params['Github Handle'])
    user = GithubUser.new(result)
    sender_name = current_user.first_name
    if user.email
      InviteMailer.invite_send(user, sender_name).deliver_now
      flash[:success] = "Successfully sent invite!"
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to '/dashboard'
  end
end
