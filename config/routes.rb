Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      resource :finances, only: :show
      concern :sellable do
        resources :items, only: [:show, :destroy]
      end
      resources :products do
        collection do
          get "/filter/(:query)", action: :index
        end

        resources :reviews, only: [:create, :destroy, :update]
        resource :adder, only: :create do
          collection do
            post "/(:amount)", action: :create
          end
        end
      end
      resources :users, only: :show do
        resource :carts, only: [:show, :destroy] do
          concerns :sellable
        end
        resources :orders, only: [:index, :show] do
          concerns :sellable
        end
      end
    end
  end
end
