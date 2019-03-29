# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserDashboardFacade do
  before :each do
    @admin = create(:admin)
    @facade = AdminDashboardFacade.new
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    @tutorials = create_list(:tutorial, 5)
  end
  it 'exists' do
    expect(@facade).to be_a(AdminDashboardFacade)
  end

  it 'gets all tutorials' do
    expect(@facade.tutorials).to eq(@tutorials)
  end
end
