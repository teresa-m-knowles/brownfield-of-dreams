# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'An Admin can edit a tutorial by changing the sequence of videos' do
  before :each do
    @tutorial = create(:tutorial)
    @video1 = create(:video, tutorial: @tutorial)
    @video2 = create(:video, tutorial: @tutorial)
    @video3 = create(:video, tutorial: @tutorial)
  end

  describe 'As a logged in admin user' do
    it 'can reorder videos' do
      @admin = create(:user, role: 1)
      allow_any_instance_of(Admin::BaseController).to receive(:current_user).and_return(@admin)

      visit edit_admin_tutorial_path(@tutorial)

      expect(page.all('.video')[0]).to have_content(@video1.title.to_s)
      expect(page.all('.video')[1]).to have_content(@video2.title.to_s)
      expect(page.all('.video')[2]).to have_content(@video3.title.to_s)

      sequence = [@video3.id, @video1.id, @video2.id]
      tutorial_sequencer = TutorialSequencer.new(@tutorial, sequence)

      tutorial_sequencer.run!

      visit edit_admin_tutorial_path(@tutorial)

      expect(page.all('.video')[0]).to have_content(@video3.title.to_s)
      expect(page.all('.video')[1]).to have_content(@video1.title.to_s)
      expect(page.all('.video')[2]).to have_content(@video2.title.to_s)
    end
  end

  describe 'A non-admin cannot edit tutorial' do
    it 'A user can not visit edit tutorial page' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit edit_admin_tutorial_path(@tutorial)

      expect(page).to have_content("The page you're looking for could not be found.")
    end

    it 'A visitor can not visit edit tutorial page' do
      visit edit_admin_tutorial_path(@tutorial)

      expect(page).to have_content("The page you're looking for could not be found.")
    end
  end
end
