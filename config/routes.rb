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
  # post 'notify_user', to: 'games#notify_user'
  
  post '/board/update_progress', to: 'boards#update_progress'
  
  scope '/admin' do
    resources :cards
  end
  
end
