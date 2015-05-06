class Video < Entry

  validates_presence_of :video

  before_validation :available_video

  private

  def available_video
    begin
      VideoInfo.new(video).available?
    rescue
      errors.add(:video, 'bad video url')
    end
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
