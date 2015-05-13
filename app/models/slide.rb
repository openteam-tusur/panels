class Slide < ActiveRecord::Base
  include RankedModel
  ranks :position

  belongs_to :panel
  belongs_to :entry

  validates_presence_of :panel_id, :entry_id, :duration, :starts_at, :ends_at
  validate :times_compare

  scope :ordered, -> { order(:position) }
  scope :available, -> { where('starts_at < :now and ends_at > :now', { :now => Time.zone.now }).ordered }

  private

  def times_compare
    if starts_at > ends_at
      errors.add(:starts_at, 'Время начала показа слайда не может быть позже времени конца показа слайда')
    end
  end

end
