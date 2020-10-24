Rails.application.routes.draw do
  get 'posts/create'
  get 'posts/destroy'
  root to: 'homes#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  
  resources :users, only: %i[index show new create edit update destroy]

  resources :posts, only: %i[create destroy]
end
