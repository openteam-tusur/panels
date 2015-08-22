class Manage::CutawaysController < Manage::ApplicationController

  def new
    @cutaway = Cutaway.new
  end

  def index
    @cutaways = Cutaway.all.order('updated_at ASC')
  end

  def show
    @cutaway = Cutaway.find(params[:id])
  end

  def create
    @cutaway = Cutaway.new(cutaway_params)
    if @cutaway.save && Slide.create(entry: @cutaway, starts_at: Time.zone.now, ends_at: Time.zone.now + 20.years, duration: 5)
      flash['succcess'] = 'Перебивка успешно создана'
      redirect_to :manage_cutaways
    else
      flash['alert'] = 'Неверное указан файл'
      render :action => :new
    end
  end

  def edit
    @cutaway = Cutaway.find(params[:id])
  end

  def update
    @cutaway = Cutaway.find(params[:id])
    if @cutaway.update_attributes(cutaway_params)
      flash['succcess'] = 'Запись отредактирована'
      redirect_to :manage_cutaways
    else
      flash['alert'] = 'Ошибка в одном из полей'
      render :action => :edit
    end
  end

  private

    def cutaway_params
      params.require(:cutaway).permit(:file, :slides_attributes => [:id, :duration, :entry_id, :panel_id, :starts_at, :ends_at ])
    end

end
