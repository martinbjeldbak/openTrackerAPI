OpenTracker::Application.routes.draw do

  root 'application#index'

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

      resources :race_sessions, only: [:show, :index, :create, :update] do
        resources :laps, only: [:create] do
          resources :positions, only: [:create]
        end
      end

      resources :users do
        collection do
          get 'search'
        end
      end
    end
  end
end