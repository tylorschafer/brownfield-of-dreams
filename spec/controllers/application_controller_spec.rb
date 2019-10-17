require 'rails_helper'

describe ApplicationController do
  before :each do
    @controller = ApplicationController.new
  end

  it '#find_bookmark finds a tutorial name by i' do
    tutorial = create(:tutorial)

    expect(@controller.tutorial_name(tutorial.id)).to eq(tutorial.title)
  end

  it '#find_bookmark finds the the correct user_video' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    video = create(:video)
    user_video = user.user_videos.create!(video: video)

    expect(@controller.find_bookmark(video.id)).to eq(user_video)
  end

  it '#four_of_four renders a Not Found page for sad path routes' do
    expect { @controller.four_oh_four }.to raise_error(ActionController::RoutingError)
  end
end
