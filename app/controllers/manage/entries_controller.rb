class Manage::EntriesController < Manage::ApplicationController
  include EntryHelpers

  helper_method :page

  def index
    @entries = current_user.entries.page(page).per(10)
  end

  def destroy
    flash_and_redirect("Запись успешно удалена", :success, :manage_entries) if Entry.find_by(:id => params[:id]).destroy
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def page
    params[:page] || 1
  end
end
