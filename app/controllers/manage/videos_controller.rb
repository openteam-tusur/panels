class Manage::VideosController < Manage::ApplicationController
  include EntryContext
  include EntryHelpers

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    flash_and_redirect_actions !!@video.save, :new
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    flash_and_redirect_actions !!@video.update_attributes(video_params), :edit
  end

  private

  def video_params
    params.require(:video).permit(:title, :video, :context_id, :slides_attributes => [:id, :duration, :entry_id, :panel_id, :starts_at, :ends_at ])
  end

end
