# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    binding.pry
    if current_user.gh_token
      render locals: {
      github_facade: UserGithubFacade.new(current_user.gh_token)
    }
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
