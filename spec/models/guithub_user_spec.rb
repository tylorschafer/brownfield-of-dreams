require 'rails_helper'

describe GithubUser do
  it 'should exsist' do
    attrs = {
      login: 'Tylor',
      html_url: 'pretend this is an address',
      avatar_url: 'https://user-images.githubusercontent.com/7718702/49523156-188b3700-f8a1-11e8-8c08-9bfbdd9119b5.png',
      email: 'tylorschafer@gmail.com'
    }

    user = GithubUser.new(attrs)

    expect(user).to be_a GithubUser
    expect(user.name).to eq(attrs[:login])
    expect(user.link).to eq(attrs[:html_url])
    expect(user.picture).to eq(attrs[:avatar_url])
    expect(user.email).to eq(attrs[:email])
  end
end
