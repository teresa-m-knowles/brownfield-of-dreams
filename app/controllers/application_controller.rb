class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :find_bookmark
  helper_method :list_tags
  helper_method :tutorial_name

  add_flash_types :success

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def find_bookmark(id)
    current_user.user_videos.find_by(video_id: id)
  end

  #Don't appear to need
  # def tutorial_name(id)
  #   Tutorial.find(id).title
  # end

  def four_oh_four
    render file: 'errors/not_found', status: 404
  end
end
