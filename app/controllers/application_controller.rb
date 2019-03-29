# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :find_bookmark
  helper_method :list_tags
  helper_method :tutorial_name

  add_flash_types :success
  before_action -> { flash.now[:notice] = flash[:notice].html_safe if flash[:html_safe] && flash[:notice] }

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    four_oh_four unless current_user
  end

  def find_bookmark(id)
    current_user.user_videos.find_by(video_id: id)
  end

  def four_oh_four
    render file: 'errors/not_found', status: 404
  end
end
