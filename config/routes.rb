Rails.application.routes.draw do
  resources :users, only: [:new, :create, :index]
  resource :session, only: [:create, :new, :destroy]
end
