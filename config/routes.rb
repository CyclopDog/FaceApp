Rails.application.routes.draw do
  # get 'user/show'
  # get 'user/index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  resources :users, only: [:show, :index]
end
