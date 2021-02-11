Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  root 'static_pages#home'
  get '/help',  to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  resources :users, param: :name
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
