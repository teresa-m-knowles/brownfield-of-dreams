# frozen_string_literal: true

class Admin::VideosController < Admin::BaseController
  def create
    tutorial  = Tutorial.find(params[:tutorial_id])
    thumbnail = YouTube::Video.by_id(new_video_params[:video_id]).thumbnail
    video     = tutorial.videos.new(new_video_params.merge(thumbnail: thumbnail))

    if video.save
      flash[:success] = 'Successfully created video.'
    else
      error_message = video.errors.full_messages.to_sentence
      flash[:error] = "Unable to create video. #{error_message}"
    end

    redirect_to edit_admin_tutorial_path(id: tutorial.id)
  end

  private

  def new_video_params
    params.require(:video).permit(:title, :description, :video_id, :thumbnail)
  end
end
