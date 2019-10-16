require 'rails_helper'

describe 'User dashoard' do
  # As a logged in user
  it 'user can see all their bookmarked videos' do
    user = create(:user)
    tutorial = create(:tutorial)
    video = create(:video, tutorial: tutorial, position: 1)
    video_2 = create(:video, tutorial: tutorial, position: 0)
    user.user_videos << video
    user.user_videos << video_2

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(:user)

    # When I visit '/dashboard'
    visit dashboard_path
    # Then I should see a list of all bookmarked segments under the Bookmarked Segments section
    expect(page).to have_css('.bookmarks')
    # And they should be organized by which tutorial they are a part of
    expect(page).to have_content(tutorial.name)
    # And the videos should be ordered by their position
    within(first('.videos')) do
      expect(page).to have_content(video_2.name)
    end

    within(last('.videos')) do
      expect(page).to have_content(video.name)
    end
  end
end
