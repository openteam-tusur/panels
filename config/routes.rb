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
    resources :services, :only => :index
    get :service, :to => 'services#show'
  end

  resources :users, :only => [] do
    get 'search', :on => :collection
  end

  get '/datetime' => 'integration#datetime'
  get '/week' => 'integration#week'
  get '/documentation' => "documentation#show"

  root 'panels#index'

end
