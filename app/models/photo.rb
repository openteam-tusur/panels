class Photo < Entry

  has_attached_file :file, :storage => :elvfs, :elvfs_url => Settings['storage.url']
  validates_attachment_content_type :file, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates_presence_of :file, :title
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
