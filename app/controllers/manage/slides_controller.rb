class Manage::SlidesController < Manage::ApplicationController
  include EntryHelpers

  before_filter :get_panel
  before_filter :get_entries, :only => [:new, :create, :edit, :update]

  def index
    @slides = @panel.slides.order('position')
  end

  def new
    @slide = Slide.new
  end

  def create
    @slide = @panel.slides.new(slide_params)
    @slide.position = @panel.slides.count + 1
    flash_and_redirect_actions !!@slide.save, :new, manage_panel_slides_path(@panel.id)
  end

  def edit
    @slide = Slide.find_by(id: params[:id])
    @entries_collection << @slide.entry
  end

  def update
    @slide = Slide.find_by(id: params[:id])
    flash_and_redirect_actions !!(@slide.valid? && @slide.update_attributes(slide_params)), :edit, manage_panel_slides_path(@panel.id)
  end

  def destroy
    @slide = Slide.find_by(id: params[:id]).destroy
    flash_and_redirect "Слайд успешно удален", :success, manage_panel_slides_path(@slide.panel)
  end

  def update_position
    params[:slides].each do |id, position|
      Slide.find(id).update_attribute(:position, position)
    end

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end

  private
    def slide_params
      params.require(:slide).permit(:entry_id, :starts_at, :ends_at, :duration, :position, :panel_id, :slide_id )
    end

    def get_panel
      @panel = Panel.find(params[:panel_id])
    end

    def get_entries
      @entries_collection = current_user.entries - @panel.entries
    end

end
