class Manage::PanelsController < Manage::ApplicationController

  def index
    @panels = Panel.all.order('id desc')
  end

  def show
    if @panel = Panel.find_by(:id => params[:id])
    else
      redirect_to manage_panels_path
      flash[:warning] = 'Не удалось найти панель с таким id'
    end
  end

  def new
    @panel = Panel.new
  end

  def create
    @panel = Panel.new(panel_params)
    if @panel.save
      flash['success'] = 'Запись успешно добавлена'
      redirect_to manage_panels_path
    else
      flash['alert'] = 'Не удалось добавить запись'
      render :action => :new
    end
  end

  def edit
    @panel = Panel.find_by(id: params[:id])
    redirect_to manage_panels_path if @panel.nil?
  end

  def update
    @panel = Panel.find_by(id: params[:id])
    if @panel.update_attributes(panel_params)
      flash['success'] = 'Запись успешно отредактирована'
      redirect_to manage_panels_path
    else
      render :action => :edit
    end
  end

  def destroy
    if Panel.find_by(:id => params[:id]).destroy
      flash['success'] = 'Запись успешно удалена'
      redirect_to manage_panels_path
    else
      flash['alert'] = 'запись с таким id не найдена'
      redirect_to manage_panels_path
    end
  end

  private

    def panel_params
      params.require(:panel).permit(:title)
    end

end
