Rails.application.routes.draw do
  get 'homepage/index'
  namespace :api do
    namespace :v1 do
      resources :bands, only: [:index]
    end
  end
  root "homepage#index"
end
