Rails.application.routes.draw do
  get 'posts/new'
  get 'posts/create'
  get 'posts/index'
  get   '/login',     to: 'sessions#new'
  post  '/login',     to: 'sessions#create'
  get   '/signup',    to: 'users#new'
  post  '/signup',    to: 'users#create'

  delete '/logout',   to: 'sessions#destroy'

  root 'posts#index'

  resources :posts,   only: [:new, :index, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
