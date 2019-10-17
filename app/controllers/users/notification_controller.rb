class Users::NotificationController < ApplicationController

  def create
    current_user.generate_token
    UserStatusMailer.activate(current_user).deliver_now
    redirect_to dashboard_path
  end

  def show
    if params[:token] == current_user.token
      current_user.update(active: true, token: nil)
    else
      redirect_to root_path
      flash[:error] = "Sorry something went wrong."
    end
  end
end
