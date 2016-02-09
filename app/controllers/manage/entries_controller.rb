class Manage::EntriesController < Manage::ApplicationController
  include EntryHelpers

  def index
    @entries = current_user.entries
  end

  def destroy
    flash_and_redirect("Запись успешно удалена", :success, :manage_entries) if Entry.find_by(:id => params[:id]).destroy
  end

  def show
    @entry = Entry.find(params[:id])
  end

end
