class Manage::ServicesController < Manage::ApplicationController

  def index
  end

  def show
    redirect_to :index and return if params[:service][:url].blank?
    @video = VideoInfo.new(params[:service][:url])
  end

end
