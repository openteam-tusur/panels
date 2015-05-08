class Manage::SlidesController < Manage::ApplicationController
  before_filter :get_panel
  before_filter :get_entries, :only => [:new, :create, :edit, :update]

  def index
    @slides = @panel.slides.order('panel_id')
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
    @entries_collection = (Entry.all - @panel.entries ) << @slide.entry
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

  private
    def slide_params
      params.require(:slide).permit(:entry_id, :starts_at, :ends_at, :duration, :position, :panel_id )
    end

    def get_panel
      @panel = Panel.find(params[:panel_id])
    end

    def get_entries
      @entries_collection = Entry.joins('left outer join slides on slides.entry_id = entries.id').where('slides.id is null or slides.panel_id != ?', @panel.id).uniq
    end

end
