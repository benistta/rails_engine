Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        # resources :merchants, only: [:index, :show]
      end
      resources :merchants, only: [:index, :show] do
      # get 'items', to: 'merchants/items#index'
      resources :items, controller: 'merchant_items', only: [:index]
      end
    end
  end
end
