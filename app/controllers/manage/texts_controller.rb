class Manage::TextsController < Manage::ApplicationController
  include EntryContext
  include EntryHelpers

  def new
    @text = Text.new
  end

  def create
    @text = Text.new(text_params)
    flash_and_redirect_actions !!@text.save, :new
  end

  def edit
    @text = Text.find(params[:id])
  end

  def update
    @text = Text.find(params[:id])
    flash_and_redirect_actions !!@text.update_attributes(text_params), :edit
  end


  private
    def text_params
      params.require(:text).permit(:text, :title, :context_id, slides_attributes: [:id, :duration, :entry_id, :panel_id, :starts_at, :ends_at, :_destroy])
    end
end
