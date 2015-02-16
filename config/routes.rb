Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show] do
    resources :goals, only: [:new, :create]
  end
  resource :session, only: [:create, :new, :destroy]
  resources :goals, only: [:edit, :update, :destroy, :show]
end
