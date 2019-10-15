class InviteController < ApplicationController

  def new
  end

  def create
    user = get_user
    sender_name = "#{current_user.first_name} #{current_user.last_name}"
    if user.email
      InviteMailer.invite_send(user, sender_name).deliver_now
      flash[:success] = "Successfully sent invite!"
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to '/dashboard'
  end

  def get_user
    service = GithubService.new(ENV['GITHUB_USER_TOKEN'])
    result = service.get_email(params['Github Handle'])
    GithubUser.new(result)
  end
end
