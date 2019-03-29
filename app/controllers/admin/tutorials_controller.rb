# frozen_string_literal: true

# Inherits from admin base controller
class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    create_tutorial

    if @tutorial.nil?
      flash[:message] = 'Invalid playlist ID. Please try again.'

      redirect_to new_admin_tutorial_path
    elsif @tutorial.save
      save_videos

      redirect_to(
        admin_dashboard_path,
        notice: %( Successfully created tutorial. #{view_context.link_to('View it here', tutorial_path(@tutorial))}.),
        flash: { html_safe: true }
      )
    else
      error_message = @tutorial.errors.full_messages.to_sentence
      flash[:error] = "Unable to create Tutorial. #{error_message}"

      render :new
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list, :title, :description, :thumbnail, :playlist_id)
  end

  def create_tutorial
    if params[:tutorial][:playlist_id]
      create_tutorial_from_playlist unless create_tutorial_from_playlist.nil?
      create_tutorial_videos unless create_tutorial_from_playlist.nil?
    else
      create_tutorial_from_input
    end
  end

  def create_tutorial_from_input
    @tutorial = Tutorial.new(tutorial_params)
  end

  def create_tutorial_from_playlist
    playlist_id = params[:tutorial][:playlist_id]
    youtube_tutorial = YouTube::Tutorial.by_id(playlist_id)

    return nil if youtube_tutorial.title.nil?

    title = youtube_tutorial.title
    description = youtube_tutorial.description

    description = 'This tutorial has no description.' if description == ''
    thumbnail = youtube_tutorial.thumbnail

    playlist_params = { title: title, description: description, thumbnail: thumbnail, playlist_id: playlist_id }

    @tutorial = Tutorial.new(playlist_params)
  end

  def create_tutorial_videos
    playlist_id = params[:tutorial][:playlist_id]
    tutorial_videos_data = YoutubeService.new.playlist_videos_info(playlist_id)

    @tutorial_videos = []
    tutorial_videos_data[:items].each do |tutorial_video|
      new_video_params = {
                          title: tutorial_video[:snippet][:title],
                          description: tutorial_video[:snippet][:description],
                          video_id: tutorial_video[:contentDetails][:videoId],
                          thumbnail: tutorial_video[:snippet][:thumbnails][:high][:url],
                          tutorial_id: @tutorial
                        }
      @tutorial_videos << Video.new(new_video_params)
    end
  end

  def save_videos
    @tutorial_videos&.each do |video|
      video.tutorial_id = @tutorial.id
      video.save
    end
  end
end
