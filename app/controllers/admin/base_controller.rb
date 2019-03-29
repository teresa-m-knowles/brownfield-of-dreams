# frozen_string_literal: true

class Admin::BaseController < ApplicationController
  before_action :require_admin!

  def require_admin!
    four_oh_four unless current_user&.admin?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
