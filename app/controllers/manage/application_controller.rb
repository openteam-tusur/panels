class Manage::ApplicationController < ApplicationController
  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => user_signed_in? ? I18n.t('access.denied') : I18n.t('access.not_authorized')
  end
end
