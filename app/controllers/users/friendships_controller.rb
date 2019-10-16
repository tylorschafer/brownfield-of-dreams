class Users::FriendshipsController < ApplicationController

  def create
    Friendship.create(user_id: current_user.id, friend_id: params[:friend_id])
  end

end
