class Manage::EntriesController < Manage::ApplicationController

  def index
    @entries = Entry.all.order('id desc')
  end

  def destroy
    if Entry.find_by(:id => params[:id]).destroy
      flash['success'] = 'Запись успешно удалена'
      redirect_to manage_entries_path
    else
      flash['alert'] = 'запись с таким id не найдена'
      redirect_to manage_entries_path
    end
  end

end