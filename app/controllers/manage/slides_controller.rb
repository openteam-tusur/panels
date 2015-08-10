class Manage::SlidesController < Manage::ApplicationController
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
    if @slide.save
      redirect_to manage_panel_slides_path(@panel.id)
      flash[:success] = 'Слайд успешно создан'
    else
      render :action => :new
    end
  end

  def edit
    @slide = Slide.find_by(id: params[:id])
    @entries_collection << @slide.entry
  end

  def update
    @slide = Slide.find_by(id: params[:id])
    if  @slide.update_attributes(slide_params) && @slide.valid?
      @slide.save
      redirect_to manage_panel_slides_path(@panel.id)
      flash[:success] = 'Слайд успешно отредактирован'
    else
      render :action => :edit
    end
  end

  def destroy
    @slide = Slide.find_by(id: params[:id])
    if @slide.destroy
      redirect_to manage_panel_slides_path(Panel.find_by(id: params[:panel_id]))
      flash[:success] = 'Слайд успешно удален'
    end
  end

  def update_position
    @slide = Slide.find(slide_params[:slide_id])
    @slide.position = slide_params[:position]
    @slide.save

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
     @entries_collection = Entry.all - @panel.entries
    end

end
