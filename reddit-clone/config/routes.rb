Rails.application.routes.draw do

  root to: "sessions#new"

  resources :users, only: [:new, :create, :show]

  resource :session, only: [:new, :create, :destroy]

  resources :subs, except: [:destroy]

  resources :posts, except: [:index, :destroy] do
    resources :comments, only: [:new, :create]
  end

  resources :comments, only: [:show] do
    member do
      get 'new'
    end
  end


end
