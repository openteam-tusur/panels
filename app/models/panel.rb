class Panel < ActiveRecord::Base
  validates_presence_of :title
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
