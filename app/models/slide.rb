class Slide < ActiveRecord::Base
  include RankedModel
  ranks :position

  belongs_to :panel
  belongs_to :entry

  validates_presence_of :panel_id, :entry_id, :duration, :starts_at, :ends_at
end
