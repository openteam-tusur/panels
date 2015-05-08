class Permission < ActiveRecord::Base
  include AuthClient::Permission

  acts_as_auth_client_permission roles: [:admin, :manager]
end

# == Schema Information
#
# Table name: permissions
#
#  id           :integer          not null, primary key
#  context_id   :integer
#  context_type :string
#  role         :string
#  user_id      :string
#  created_at   :datetime
#  updated_at   :datetime
#
