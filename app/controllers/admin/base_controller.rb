# frozen_string_literal: true

module Admin
  # Restricts admin actions to admin user
  class BaseController < ApplicationController
    before_action :require_admin!

    def require_admin!
      four_oh_four unless current_user&.admin?
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end
end
