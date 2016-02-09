class Manage::PhotosController < Manage::ApplicationController
  include EntryContext
  include EntryHelpers

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    flash_and_redirect_actions !!@photo.save, :new
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    flash_and_redirect_actions !!@photo.update_attributes(photo_params), :edit
  end

  private

    def photo_params
      params.require(:photo).permit(:title, :file, :context_id, slides_attributes: [:id, :duration, :entry_id, :panel_id, :starts_at, :ends_at ])
    end

end
