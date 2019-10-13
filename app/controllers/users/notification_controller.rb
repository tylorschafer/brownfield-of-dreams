class Users::NotificationController < ApplicationController

  def create
    UserStatusMailer.activate(current_user).deliver_now
    redirect_to root_path
  end

  def show
    current_user.update(active: true)
  end

end
