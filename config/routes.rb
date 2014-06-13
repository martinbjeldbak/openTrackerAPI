OpenTracker::Application.routes.draw do
  require 'api_constraints'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'application#index'

  resources :users do
    collection do
      get 'search'
    end
  end

  namespace :api, defaults: {format: :json} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true) do
      resources :sessions, only: [:show, :index, :create, :update]
    end
  end
end