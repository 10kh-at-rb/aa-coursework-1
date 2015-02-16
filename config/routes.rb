Rails.application.routes.draw do
  resources :users, only: [:new, :create, :index] do
    resources :goals, only: [:index, :new, :create]
  end
  resource :session, only: [:create, :new, :destroy]
  resources :goals, only: [:edit, :update, :destroy]
end
