Rails.application.routes.draw do
  get 'panel/show'
  resources:'panels', :only => :show
end
