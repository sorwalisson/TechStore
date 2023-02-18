Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      concern :sellable do
        resources :items, only: [:show, :destroy]
      end
      resources :products do
        collection do
          get "/filter/(:query)", action: :index
        end

        resources :reviews, only: [:create, :destroy]
        resource :adder, only: :create
      end
      resources :users, only: :index do
        resource :carts, only: [:index, :destroy] do
          concerns :sellable
        end
        resources :orders, only: [:index, :show] do
          concerns :sellable
        end
      end
    end
  end
end
