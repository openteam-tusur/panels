class Entry < ActiveRecord::Base

  validates_presence_of :title
  has_many :slides, :dependent => :destroy
  has_many :panels, :through => :slides

  accepts_nested_attributes_for :slides,  :allow_destroy => true, :reject_if => :slide_invalid?

  private

    def slide_invalid?(attributed)
      Panel.find(attributed['panel_id']).slides.map(&:entry_id).include? self.id
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
