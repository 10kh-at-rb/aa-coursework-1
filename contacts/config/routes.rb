FirstRoutes::Application.routes.draw do
  resources :users do
    resources :contacts, only: :index
  end

  # get 'users' => 'users#index'
  # post 'users' => 'users#create'
  # get 'users/new' => 'users#new', :as => 'new_user'
  # get 'users/:id/edit' => 'users#edit', :as => 'edit_user'
  # get 'users/:id' => 'users#show', :as => 'user'
  # patch 'users/:id' => 'users#update'
  # put 'users/:id' => 'users#update'
  # delete 'users/:id' => 'users#destroy'

  #resources :contacts
  post 'contacts' => 'contacts#create'
  get 'contacts/new' => 'contacts#new', :as => 'new_contact'
  get 'contacts/:id/edit' => 'contacts#edit', :as => 'edit_contact'
  get 'contacts/:id' => 'contacts#show', :as => 'contact'
  patch 'contacts/:id' => 'contacts#update'
  put 'contacts/:id' => 'contacts#update'
  delete 'contacts/:id' => 'contacts#destroy'

  resources :contact_shares, only: [:create, :destroy]
end
