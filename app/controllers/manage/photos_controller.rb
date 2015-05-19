class Manage::PhotosController < Manage::ApplicationController

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      flash['succcess'] = 'Запись создана'
      redirect_to :manage_entries
    else
      flash['alert'] = 'Ошибка в одном из полей'
      render :action => :new
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(photo_params)
      flash['succcess'] = 'Запись отредактирована'
      redirect_to :manage_entries
    else
      flash['alert'] = 'Ошибка в одном из полей'
      render :action => :edit
    end
  end

  private

    def photo_params
      params.require(:photo).permit(:title, :file, :slides_attributes => [:id, :duration, :entry_id, :panel_id, :starts_at, :ends_at ])
    end

end
