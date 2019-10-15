require 'rails_helper'

describe Repo do
  it 'exists' do
    attrs = {
      name: 'Test Repo',
      html_url: 'https://www.github.com/users/tylorschafer'
    }

    repo = Repo.new(attrs)

    expect(repo).to be_a Repo
    expect(repo.name).to eq(attrs[:name])
    expect(repo.html_url).to eq(attrs[:html_url])
  end
end
