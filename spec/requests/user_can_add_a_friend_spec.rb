# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User can add a friend', type: :request do
  before :each do
    @user1 = create(:user, uid: '12')
    create(:github_token, user: @user1, token: ENV['USER_1_GITHUB_TOKEN'])

    @user2 = create(:user, uid: '34')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    stub_user_1_dashboard
  end

  describe 'if I send a valid post request for a friendship' do
    it 'should create a friendship' do
      post '/friendships', params: { friend: @user2.uid }

      expect(response).to have_http_status(302)

      follow_redirect!

      expect(response.body).to include("#{@user2.first_name} added as a friend.")
    end
  end

  describe 'if I send an invalid post request for a friendship' do
    it 'should show me an error message and not create the friendship' do
      post '/friendships', params: { friend: '' }

      expect(response).to have_http_status(302)

      follow_redirect!

      expect(response.body).to include('Invalid friend request')
    end
  end
end
