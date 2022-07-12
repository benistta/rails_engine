Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      get '/merchants/find', to: 'merchants_search#find'
      get '/items/find_all', to: 'items_search#find_all'  
      namespace :merchants do
        # resources :merchants, only: [:index, :show]
      end
      resources :merchants, only: [:index, :show] do
      # get 'items', to: 'merchants/items#index'
      resources :items, controller: 'merchant_items', only: [:index]
      end
      resources :items, only: [:index, :show, :create, :update] do
        resources :merchant, controller: 'items_merchants'
      end
    end
  end
end
