class Entry < ActiveRecord::Base

  validates_presence_of :title

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
