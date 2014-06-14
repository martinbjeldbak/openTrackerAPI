OpenTracker::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'application#index'

  resources :users do
    collection do
      get 'search'
    end
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :sessions, only: [:show, :index, :create, :update] do
        resources :laps, only: [:index, :update, :create]
      end
    end
  end
end