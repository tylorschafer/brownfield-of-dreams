class Users::FriendshipsController < ApplicationController

  def create
    current_user.friendships << Friendship.create(
      user_id: current_user.id,
      friend_id: params[:friend_id].to_i
    )
    current_user.reload
    redirect_to dashboard_path
  end
end
