OpenTracker::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#index'

  #devise_for :users
  resources :users

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :sessions
    end
  end
end
