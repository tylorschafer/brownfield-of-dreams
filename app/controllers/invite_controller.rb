# frozen_string_literal: true

class InviteController < ApplicationController
  def new; end

  def create
    user = gh_user
    sender_name = "#{current_user.first_name} #{current_user.last_name}"
    if user.email
      InviteMailer.invite_send(user, sender_name).deliver_now
      flash[:success] = 'Successfully sent invite!'
    else
      flash[:error] =
        "The Github user you've selected doesn't have a public email"
    end
    redirect_to '/dashboard'
  end

  def gh_user
    service = GithubService.new(ENV['GITHUB_USER_TOKEN'])
    result = service.get_email(params['Github Handle'])
    GithubUser.new(result)
  end
end
