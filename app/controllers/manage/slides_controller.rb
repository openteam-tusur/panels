class Manage::SlidesController < Manage::ApplicationController

  def index
    if @panel = Panel.find_by(id: params[:panel_id])
        @slides = @panel.slides.order('panel_id')
    else
      redirect_to manage_panels_path
      flash[:warning] = "Панель с id #{params[:panel_id]} не найдена"
    end
  end

  def new
    @slide = Slide.new
    @panel = Panel.find_by(id: params[:panel_id])
  end

  def create
    raise params[]
    @slide = Slide.new(slide_params)
    @panel = Panel.find_by(id: params[:panel_id])
    @slide.position = @panel.slides.count + 1
    @slide.panel = @panel
    if @slide.save
      redirect_to manage_panel_slides_path(@panel.id)
      flash[:success] = 'Слайд успешно создан'
    else
      render :action => :new
    end
  end

  def edit
    @slide = Slide.find_by(id: params[:id])
    @panel = Panel.find_by(id: params[:panel_id])
  end

  def update
    @slide = Slide.find_by(id: params[:id])
    @panel = Panel.find_by(id: params[:panel_id])
    if  @slide.update_attributes(slide_params) && @slide.valid?
      @slide.save
      redirect_to manage_panel_slides_path(@panel.id)
      flash[:success] = 'Слайд успешно отредактирован'
    else
      render :action => :edit
    end
  end

  private
    def slide_params
      params.require(:slide).permit(:entry_id, :starts_at, :ends_at, :duration, :position, :panel_id )
    end

end
