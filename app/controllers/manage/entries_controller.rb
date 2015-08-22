class Manage::EntriesController < Manage::ApplicationController

  def index
    @entries = Entry.all.where.not(:type => 'Cutaway').order('id desc')
  end

  def destroy
    if Entry.find_by(:id => params[:id]).destroy
      redirect :success, 'Запись успешно удалена'
    else
      redirect :alert, 'Запись с таким id не найдена'
    end
  end

  def show
    @entry = Entry.find(params[:id])
  end

  private

    def redirect(status, message)
      redirect_to manage_entries_path
      flash[status] = message
    end

end
