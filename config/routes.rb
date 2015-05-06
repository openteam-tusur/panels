Rails.application.routes.draw do

  resources :panels, :only => :show

  namespace :manage do
    resources :entries, :only => [:index, :destroy]
    resources :photos, :only => [:new, :create, :edit, :update]
    resources :videos, :only => [:new, :create, :edit, :update]
    resources :texts, :only => [:new, :create, :edit, :update]
  end

  root 'application#index'

end
