Rails.application.routes.draw do
  resources :users, only: [:create, :new, :show] do
    collection do
      get 'activate'
    end
  end

  resource :session, only: [:create, :new, :destroy]

  resources :bands do
    resources :albums, only: [:new, :create]
  end

  resources :albums, except: [:index, :new] do
    resources :tracks, only: [:new, :create]
  end

  resources :tracks, except: [:index, :new] do
    resources :notes, only: [:create, :destroy]
  end
end
