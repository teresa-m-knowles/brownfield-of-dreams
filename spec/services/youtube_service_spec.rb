require 'rails_helper'

RSpec.describe YoutubeService do
  before :each do
    #@user1 = create(:user)
    #create(:github_token, user: @user1, token: ENV['USER_1_GITHUB_TOKEN'])
  end

  it "exists" do
    service = YoutubeService.new
    expect(service).to be_a(YoutubeService)
  end

  context "instance methods", :vcr do
    it "gets video_info" do
      id = "qMkRHW9zE1c"
      service = YoutubeService.new

      results = service.video_info(id)
      video_data = results[:items].first
      expect(video_data[:snippet][:thumbnails][:high][:url]).to eq("https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg")
    end

    it "gets tutorial_info" do
      playlist_id = "PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5"
      service = YoutubeService.new

      results = service.tutorial_info(playlist_id)
      tutorial_data = results[:items].first
      expect(tutorial_data[:snippet][:title]).to eq("Back End Engineering - Prework")
      expect(tutorial_data[:snippet][:description]).to eq("")
      expect(tutorial_data[:snippet][:thumbnails][:high][:url]).to eq("https://i.ytimg.com/vi/XsPVWGKK0qI/hqdefault.jpg")
    end

    it "playlist_videos_info" do
      playlist_id = "PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5"
      service = YoutubeService.new

      results = service.playlist_videos_info(playlist_id)
      expect(results[:items].count).to eq(4)

      video_data = results[:items].first
      expect(video_data[:snippet][:title]).to eq("Prework - Environment Setup")
      expect(video_data[:snippet][:description]).to eq("")
      expect(video_data[:contentDetails][:videoId]).to eq("qMkRHW9zE1c")
      expect(video_data[:snippet][:thumbnails][:high][:url]).to eq("https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg")
    end

  end
end
