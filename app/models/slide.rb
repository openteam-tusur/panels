class Slide < ActiveRecord::Base

  belongs_to :panel
  belongs_to :entry

  validates_presence_of :panel_id, :entry_id, :duration, :starts_at, :ends_at
  validates :position, uniqueness: { :scope => :panel_id, :message => "В панели уже есть слайд с таким порядковым номером"}
end
