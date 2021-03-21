Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get '/signup', to: 'users#new'
  root 'static_pages#home'
  get '/help',  to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users, param: :name do 
    member do
      get :following, :followers
    end
  end
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,        only: [:create, :destroy, :create_mini, :destroy_mini]
  post   '/relationships_mini',   to: 'relationships#create_mini'
  delete '/relationships_mini/:id',  to: 'relationships#destroy_mini'
  post '/guest_sign_in', to: 'static_pages#new_guest'
  post '/likes/:id/create', to: 'likes#create'
  delete '/likes/:id/destroy', to: 'likes#destroy'
  get '/users/:name/likes', to: 'microposts#like'
end
