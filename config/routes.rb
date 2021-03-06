Rails.application.routes.draw do
  
  devise_for :users, :controllers => { sessions: "sessions", registrations: "registrations" }

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  # resources :home
  get '/home', to: 'home#index'

  resources :games, except: [:new, :destroy]
  get 'games/counters/:id', to: 'games#counters'
  
  post '/board/update_progress', to: 'boards#update_progress'

  namespace :admin do
    resources :users, only: [:index, :destroy]
  end
  
  scope '/admin' do
    resources :cards
  end
  
end
