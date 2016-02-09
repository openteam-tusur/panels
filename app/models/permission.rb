class Permission < ActiveRecord::Base

  include ContextMethods
  include AuthClient::Permission

  acts_as_auth_client_permission roles: [:admin, :manager]

  attr_accessor :name

  delegate :fullname, :email, :to => :user, :prefix => true, :allow_nil => true

  validates_uniqueness_of :role, :scope => :user_id,
    :message => 'У пользователя не может быть несколько одинаковых ролей'
  validates :context_id, presence: true, if: ->(p){ p.role == "manager"}

  def role_text
    I18n.t("role_names.#{role}", :title => '').strip
  end

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
