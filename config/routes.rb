Rails.application.routes.draw do

  mount ElVfsClient::Engine => '/'

  resources :panels, :only => [:index, :show]

  namespace :manage do
    resources :entries, :only => [:index, :destroy, :show]
    resources :cutaways
    resources :photos, :only => [:new, :create, :edit, :update]
    resources :videos, :only => [:new, :create, :edit, :update]
    resources :texts, :only => [:new, :create, :edit, :update]
    resources :permissions, :only => [:index, :new, :create, :destroy]
    resources :panels do
      resources :slides do
        post :update_position, :on => :collection
      end
    end
  end

  resources :users, :only => [] do
    get 'search', :on => :collection
  end

  get '/time' => 'integration#time_and_week'

  root 'panels#index'

end
