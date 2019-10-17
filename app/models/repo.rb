# frozen_string_literal: true

class Repo
  attr_reader :name, :html_url

  def initialize(paramaters = {})
    @name = paramaters[:name]
    @html_url = paramaters[:html_url]
  end
end
