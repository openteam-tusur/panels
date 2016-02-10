class Entry < ActiveRecord::Base

  include ContextMethods
  has_many :slides, :dependent => :destroy
  has_many :panels, :through => :slides

  accepts_nested_attributes_for :slides,  :allow_destroy => true, :reject_if => :all_except_datetime_is_blank
  validates :context_id, presence: true

  scope :except_cutaways, -> { where.not(type: 'Cutaway') }
  scope :ordered, -> { order('id desc') }

  private

  def all_except_datetime_is_blank(attributes)
    attributes["panel_id"].blank?
  end

end

# == Schema Information
#
# Table name: entries
#
#  id                :integer          not null, primary key
#  title             :string
#  type              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  text              :text
#  video             :string
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#  file_url          :text
#
