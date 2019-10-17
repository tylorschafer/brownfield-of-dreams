class UserShowFacade
  # frozen_string_literal: true
  attr_reader :token

  def initialize(user)
    @user = user
    @token = @user.gh_token
  end

  def active?
    @user.active == true ? 'Active' : 'Not Activated'
  end

  def bookmarks
    @user.bookmarks_by_tutorial
  end

  def email
    @user.email
  end

  def find_user(handle)
    User.in_system?(handle)
  end

  def first_name
    @user.first_name
  end

  def followers
    service.followers.map do |repo_data|
      GithubUser.new(repo_data)
    end
  end

  def following
    service.following.map do |repo_data|
      GithubUser.new(repo_data)
    end
  end

  def friends
    @user.friends
  end

  def has_friend?(handle)
    @user.has_friend?(handle)
  end

  def last_name
    @user.last_name
  end

  def repos
    service.repos.map do |repo_data|
      Repo.new(repo_data)
    end.first(5)
  end

  def service
    GithubService.new(@token)
  end

  def user_id(name)
    find_user(name).id
  end
end
