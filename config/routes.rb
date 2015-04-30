Rails.application.routes.draw do
  resources:'panels', :only => :show
end
