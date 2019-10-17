require 'rails_helper'

describe 'OmniAuth handshake' do
  before :each do
    OmniAuth.config.test_mode = true
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    repo_1 = Repo.new({name: 'fakerepo', html_url: 'fakeurl.com'})
    repo_2 = Repo.new({name: 'fakerepo_duex', html_url: 'fakeurl.com'})

    allow_any_instance_of(UserShowFacade).to receive(:repos).and_return([repo_1, repo_2])

    gh_user = GithubUser.new({
      login: 'fakeuser',
      html_url: 'www.google.com',
      avatar_url: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12231413/Labrador-Retriever-MP.jpg',
      email: 'fake@fakeuser.com'
      })

    allow_any_instance_of(UserShowFacade).to receive(:followers).and_return([gh_user])
    allow_any_instance_of(UserShowFacade).to receive(:following).and_return([gh_user])

    visit dashboard_path
  end
#
  xit 'can sign users into github' do
    allow_any_instance_of(GithubController).to receive(:auth_hash).and_return(mock_auth_hash)

    click_on 'Connect to Github'

    expect(page).to have_content(@user.first_name)
  end
end
