class GithubUser
  # frozen_string_literal: true

  attr_reader :name, :link, :picture, :email

  def initialize(params = {})
    @name = params[:login]
    @link = params[:html_url]
    @picture = params[:avatar_url]
    @email = params[:email]
  end

end
