class Manage::VideosController < Manage::ApplicationController

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash['success'] = 'Запись добавлена'
      redirect_to :manage_entries
    else
      flash['alert'] = 'Ошибка в одном из полей'
      render :new
    end
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update_attributes(video_params)
      flash['success'] = 'Запись отредактирована'
      redirect_to :manage_entries
    else
      flash['alert'] = 'Ошибка в одном из полей'
      render :edit
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :video)
  end

end
