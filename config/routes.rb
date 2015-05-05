Rails.application.routes.draw do
  resources:'panels', :only => :show

  root 'application#index'
end
