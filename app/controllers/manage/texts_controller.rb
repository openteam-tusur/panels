class Manage::TextsController < Manage::ApplicationController

  def new
    @text = Text.new
  end

  def create
    @text = Text.new(text_params)
    if @text.save
      flash['success'] = 'Запись добавлена'
      redirect_to :manage_entries
    else
      flash['alert'] = 'Ошибка в одном из полей'
      render :action => :new
    end
  end

  def edit
    @text = Text.find(params[:id])
  end

  def update
    @text = Text.find(params[:id])
    if @text.update_attributes(text_params)
      flash['success'] = 'Запись отредактирована'
      redirect_to :manage_entries
    else
      flash['alert'] = 'Ошибка в одном из полей'
      render :action => :edit
    end
  end


  private
    def text_params
      params.require(:text).permit(:text, :title, :slides_attributes => [:id, :duration, :entry_id, :panel_id, :starts_at, :ends_at ])
    end
end
