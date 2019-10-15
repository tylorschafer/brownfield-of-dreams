require 'rails_helper'

describe 'Github Service', :vcr do
  before :each do
    @service = GithubService.new(ENV['GITHUB_USER_TOKEN'])
  end

  it 'Pulls in repo data for users'do
    result = @service.repos
    expect(result).to be_an Array
    expect(result[0]).to be_a Hash
    expect(result[0][:name]).to be_a String
  end

  it 'Pulls in follower data for users'do
    result = @service.followers
    expect(result).to be_an Array
    expect(result[0]).to be_a Hash
    expect(result[0][:url]).to be_a String
  end

  it 'Pulls in following data for users'do
    result = @service.following
    expect(result).to be_an Array
    expect(result[0]).to be_a Hash
    expect(result[0][:url]).to be_a String
  end

  it 'Finds an email for valid github handles'do
    result = @service.get_email('tylorschafer')
    expect(result).to be_a Hash
    expect(result[:email]).to be_a String

    bad_result = @service.get_email('sadpathtylor')
    expect(bad_result[:email]).to be_nil
  end
end
