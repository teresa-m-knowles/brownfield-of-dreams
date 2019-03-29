require 'rails_helper'

RSpec.describe "Admin can create a video" do
  describe 'As a logged in admin user' do
    before :each do
      @admin = create(:user, role: 1)
      @tutorial = create(:tutorial)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end

    describe 'when I visit my dashboard' do
      describe 'and I click on the edit button for a tutorial' do
        describe 'when I click on Add Video' do
          describe 'and I enter valid video information' do
            it 'can create a new video for that tutorial', :js do
              VCR.use_cassette("admin/admin_can_create_a_new_video") do
                visit admin_dashboard_path

                within "#tutorial-#{@tutorial.id}" do
                  click_link "Edit"
                end

                expect(current_path).to eq(edit_admin_tutorial_path(@tutorial))

                click_on "Add Video"

                fill_in "video[title]", with: "How to tie your shoes."
                fill_in "video[description]", with: "Over, under, around and through, Meet Mr. Bunny Rabbit, pull and through."
                fill_in "video[video_id]", with: "J7ikFUlkP_k"
                click_on "Create Video"
                expect(page).to have_content("Successfully created video.")

                expect(current_path).to eq(edit_admin_tutorial_path(@tutorial))

                within(first(".video")) do
                  expect(page).to have_content("How to tie your shoes.")
                end
              end

            end
          end

          describe 'and I enter invalid video information' do
            it 'can create a new video for that tutorial', :js do
              VCR.use_cassette("admin/admin_canot_create_a_new_video_invalid_info") do
                visit admin_dashboard_path

                within "#tutorial-#{@tutorial.id}" do
                  click_link "Edit"
                end

                expect(current_path).to eq(edit_admin_tutorial_path(@tutorial))

                click_on "Add Video"

                fill_in "video[title]", with: ""
                fill_in "video[description]", with: "Over, under, around and through, Meet Mr. Bunny Rabbit, pull and through."
                fill_in "video[video_id]", with: "0"
                click_on "Create Video"

                expect(page).to_not have_content("Successfully created video.")
                expect(page).to have_content("Unable to create video. Title can't be blank and Thumbnail can't be blank")
                
                expect(current_path).to eq(edit_admin_tutorial_path(@tutorial))

              end

            end
          end
        end
      end
    end
  end
end
