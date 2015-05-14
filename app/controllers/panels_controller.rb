class PanelsController < ApplicationController

  def index
    @panels = Panel.all
  end

  def show
    panel = Panel.find(params[:id])
    redirect_to panels_path and return if params[:id].blank? || panel.blank?
    @slide = panel.next_slide(params[:current])
    redirect_to panels_path and return if @slide.blank?

    render :layout => request.xhr? ? false : 'public'
  end

end
