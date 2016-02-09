class Manage::PanelsController < Manage::ApplicationController
  include EntryContext
  include EntryHelpers

  def index
    @panels = current_user.panels.sort_by(&:updated_at)
  end

  def show
    @panel = Panel.find_by(:id => params[:id])
  end

  def new
    @panel = Panel.new
  end

  def create
    @panel = Panel.new(panel_params)
    flash_and_redirect_actions !!@panel.save, :new, :manage_panels
  end

  def edit
    @panel = Panel.find_by(id: params[:id])
  end

  def update
    @panel = Panel.find_by(id: params[:id])
    flash_and_redirect_actions !!@panel.update_attributes(panel_params), :edit, :manage_panels
  end

  def destroy
    if Panel.find_by(:id => params[:id]).destroy
      flash_and_redirect "Запись успешно удалена", :success, :manage_panels
    end
  end

  private

    def panel_params
      params.require(:panel).permit(:title, :context_id)
    end

end
