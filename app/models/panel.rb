class Panel < ActiveRecord::Base
  has_many :slides
  has_many :entries, :through => :slides
  validates_presence_of :title

  def next_slide(current_id)
    slides = self.slides.available
    next_index = 0
    next_index = slides.map(&:id).find_index(current_id.to_i) + 1 if current_id.present?
    next_index = 0 if next_index > slides.count - 1

    slides[next_index]    
  end

  def active?
    self.slides.available.any?
  end

end

# == Schema Information
#
# Table name: panels
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
