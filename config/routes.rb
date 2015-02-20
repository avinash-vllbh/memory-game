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

  resources :home

  resources :games

  post 'notify_user', to: 'games#notify_user'
  
  post '/board/update_progress', to: 'boards#update_progress'
  # get '/board/update_progress/:id', to: 'boards#update_progress'
  
  resources :cards
  
end
