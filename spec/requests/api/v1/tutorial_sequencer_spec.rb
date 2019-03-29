
require 'rails_helper'

RSpec.describe 'Admin::Api::V1::TutorialSequencerController', type: :request do
  describe 'As an admin' do
    it 'require user to be an admin' do

      tutorial = create(:tutorial, id: 12)
      vid_1 =  create(:video, tutorial: tutorial, position: 1, id: 12345)
      vid_2 =  create(:video, tutorial: tutorial, position: 2, id: 123456)
      vid_3 =  create(:video, tutorial: tutorial, position: 3, id: 1234567)
      admin = create(:admin)

      sequence = Hash.new
      sequence[:tutorial_sequencer] = { :_json => ['1234567']}
      allow_any_instance_of(Admin::Api::V1::BaseController).to receive(:current_user).and_return(admin)

      put admin_api_v1_path(tutorial, sequence)

      expect(response).to have_http_status(200)

      videos = JSON.parse(response.body)["videos"]

      video_3_json = videos.find do |video_hash|
        video_hash["id"] == vid_3.id
      end

      expect(video_3_json["position"]).to eq(1)

    end
  end
end
