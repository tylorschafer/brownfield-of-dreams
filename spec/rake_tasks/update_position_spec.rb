require 'rails_helper'
require 'rake'

describe 'Videos update position rake task' do
  it "video position is updated" do
    skip
    ## This test only passes when the video position validation is removed
    PersonalProject::Application.load_tasks
    t = create(:tutorial)
    create(:video, tutorial: t, position: 0)
    create(:video, tutorial: t, position: 1)
    v3 = create(:video, tutorial: t, position: nil)
    Rake::Task["videos:update_positions"].invoke

    v3.reload
    expect(v3.position).to eq(2)
  end
end
