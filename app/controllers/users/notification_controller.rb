class Users::NotificationController < ApplicationController

  def create
    UserStatusMailer.activate(current_user).deliver_now
    redirect_to root_path
  end

  def show

  end

end
