require 'rails_helper'

RSpec.describe 'Admin can create a Tutorial' do
  describe 'As a logged in admin user' do
    before :each do
      @admin = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end
    describe 'when I visit my dashboard' do
      describe 'and click on New Tutorial' do
        describe 'and I choose to create a new tutorial by adding videos individually' do
          it 'I can create a new tutorial' do
            visit admin_dashboard_path

            click_link("New Tutorial")

            expect(current_path).to eq(new_admin_tutorial_path)

            fill_in 'tutorial[title]', with: 'Tutorial Title Test'
            fill_in 'tutorial[description]', with: 'Tutorial description test'
            fill_in 'tutorial[thumbnail]', with: 'https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg'
            click_on "Save"

            expect(page).to have_content("Successfully created tutorial.")

            new_tutorial = Tutorial.last
            expect(new_tutorial.title).to eq('Tutorial Title Test')
            expect(current_path).to eq(admin_dashboard_path)
            expect(page).to have_content('Tutorial Title Test')

            click_on(new_tutorial.title)
            expect(current_path).to eq(tutorial_path(new_tutorial))

          end

          it 'if tutorial info is missing, it reloads the page' do
            visit admin_dashboard_path

            click_link("New Tutorial")

            expect(current_path).to eq(new_admin_tutorial_path)

            fill_in 'tutorial[title]', with: ''
            fill_in 'tutorial[description]', with: ''
            fill_in 'tutorial[thumbnail]', with: ''
            click_on "Save"

            expect(page).to have_content("Unable to create Tutorial.")
            expect(page).to have_content("Title can't be blank, Title is too short (minimum is 1 character)")
            expect(page).to have_content("Description can't be blank, Description is too short (minimum is 1 character)")
            expect(page).to have_content("Thumbnail can't be blank, and Thumbnail is too short (minimum is 1 character)")

            expect(Tutorial.last).to eq(nil)
          end
        end

        describe 'and I choose to create a new tutorial by importing a youtube playlist' do
          it 'I can create a new tutorial with a playlist id' do
            filename1 = 'youtube_playlist_tutorial.json'
            url1 = "https://www.googleapis.com/youtube/v3/playlists?id=Example_playlist_ID&key=AIzaSyC5s0-3RoZH77LheyC7EPNI0JLZVnTA20M&part=snippet"
            stub_get_json(url1, filename1)

            filename2 = 'youtube_playlist_videos.json'
            url2 = "https://www.googleapis.com/youtube/v3/playlistItems?key=AIzaSyC5s0-3RoZH77LheyC7EPNI0JLZVnTA20M&part=snippet,contentDetails&playlistId=Example_playlist_ID"
            stub_get_json(url2, filename2)

            #When I visit '/admin/tutorials/new'
            visit new_admin_tutorial_path

            #Then I should see a link for 'Import YouTube Playlist'
            expect(page).to have_link('Import YouTube Playlist')

            #When I click 'Import YouTube Playlist'
            click_on "Import YouTube Playlist"

            #Then I should see a form
            expect(page).to have_css('#new-playlist-form')

            #And when I fill in 'Playlist ID' with a valid ID
            fill_in 'tutorial[playlist_id]', with: 'Example_playlist_ID'

            click_on "Create Playlist"

            new_tutorial = Tutorial.last
            expect(new_tutorial.title).to eq('Playlist Tutorial Test')

            #Then I should be on '/admin/dashboard'
            expect(current_path).to eq(admin_dashboard_path)
            expect(page).to have_content('Playlist Tutorial Test')

            #And I should see a flash message that says 'Successfully created tutorial. View it here.'
            expect(page).to have_content("Successfully created tutorial. View it here.")
            #And 'View it here' should be a link to '/tutorials/:id'
            expect(page).to have_link('View it here', href: tutorial_path(new_tutorial))

            #And when I click on 'View it here'
            click_on "View it here"
            #Then I should be on '/tutorials/:id'
            expect(current_path).to eq(tutorial_path(new_tutorial))

            #And I should see all videos from the YouTube playlist
            #And the order should be the same as it was on YouTube
            expect(page.all('.tutorial-video')[0]).to have_content("Playlist video 1")
            expect(page).to have_content("Playlist video 1")
            expect(page.all('.tutorial-video')[1]).to have_content("Playlist video 3")
            expect(page).to have_content("Playlist video 3")
            expect(page.all('.tutorial-video')[2]).to have_content("Playlist video 2")
            expect(page).to have_content("Playlist video 2")
          end

          it 'if playlist id is invalid, it does not create a tutorial' do
            filename = 'bad_youtube_playlist_tutorial.json'
            url = "https://www.googleapis.com/youtube/v3/playlists?id=bad_playlist_ID&key=AIzaSyC5s0-3RoZH77LheyC7EPNI0JLZVnTA20M&part=snippet"
            stub_get_json(url, filename)

            visit new_admin_tutorial_path

            click_on "Import YouTube Playlist"

            fill_in 'tutorial[playlist_id]', with: 'bad_playlist_ID'

            click_on "Create Playlist"

            expect(page).to have_content("Invalid playlist ID. Please try again.")

            expect(current_path).to eq(new_admin_tutorial_path)

            expect(Tutorial.last).to eq(nil)
            expect(Video.last).to eq(nil)
          end
        end

      end
    end
  end
end
