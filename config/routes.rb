Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :products do
        collection do
          get "/filter/(:query)", action: :index
        end

        resources :reviews, only: [:create, :destroy]
      end
    end
  end
end
