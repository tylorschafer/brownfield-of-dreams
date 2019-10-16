class Users::FriendshipsController < ApplicationController

  def create
    friendship = create_friendship
    if friendship.save
      current_user.reload
    else
      flash[:error] = friendship.errors.full_messages.to_sentence
    end
    redirect_to dashboard_path
  end

  def create_friendship
    Friendship.create(
      user_id: current_user.id,
      friend_id: params[:friend_id].to_i
    )
  end
end
