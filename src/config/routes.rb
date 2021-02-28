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
  resources :users, param: :name
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
end
