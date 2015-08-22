class Slide < ActiveRecord::Base

  include RankedModel
  ranks :position

  belongs_to :panel
  belongs_to :entry

  before_save :get_duration

  validates_presence_of :entry_id, :duration, :starts_at, :ends_at
  validate :times_compare
  validates_presence_of :panel_id, unless: Proc.new { |a| a.entry.type == 'Cutaway' }

  scope :ordered, -> { order(:position) }
  scope :available, -> { where('starts_at < :now and ends_at > :now', { :now => Time.zone.now }).ordered }

  default_value_for :duration, 30

  private

    def times_compare
      if starts_at > ends_at
        errors.add(:starts_at, 'Время начала показа слайда не может быть позже времени конца показа слайда')
      end
    end

    def get_duration
      if entry.type == "Video"
        self.duration = VideoInfo.new(entry.video).duration
      end
    end

end
