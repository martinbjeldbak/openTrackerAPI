OpenTracker::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  concern :paginatable do
    get '(page/:page)', :action => :index, :on => :collection, :as => ''
  end

  root 'application#index'

  #resources :events
  resources :tracks, only: [:index, :show]

  resources :users do
    resources :race_sessions, only: [:show, :index, :create, :update], concerns: :paginatable do
      resources :laps, only: [:create, :show, :index] do
        resources :positions, only: [:create]
      end
    end

    collection do
      get 'search'
    end
  end
end
