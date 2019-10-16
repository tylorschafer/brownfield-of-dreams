class UserShowFacade
  # frozen_string_literal: true

  def initialize(user)
    @user = user
    @token = @user.gh_token
  end

  def bookmarks
    @user.bookmarks_by_tutorial
  end

  def friends
    @user.friends
  end

  def service
    GithubService.new(@token)
  end

  def repos
    service.repos.map do |repo_data|
      Repo.new(repo_data)
    end.first(5)
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

  def find_user(name)
    User.in_system?(name)
  end

  def user_id(name)
    find_user(name).id
  end
end
