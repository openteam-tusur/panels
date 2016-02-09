class PanelsController < ApplicationController

  def index
    @panels = Panel.all
  end

  def show
    panel = Panel.find(params[:id])
    redirect_to panels_path and return if params[:id].blank? || panel.blank?
    @slide = panel.next_slide(params[:current_slide])
    redirect_to panels_path and return if @slide.blank?

    render :layout => request.xhr? ? false : 'public'
  end

  private

    def next_cutaway(id)
      slides = Slide.where(panel_id: nil)
      if id.present?
        slide = Slide.find(id)
        index = slides.find_index(slide) + 1
        index = 0 if slides.last == slide || slide.nil?
      else
        index = 0
      end
      slides[index]
    end

end
