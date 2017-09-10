Rails.application.routes.draw do
  root to: 'pages#show', id: 'home'
  get 'pages/:id', to: 'pages#show', as: :page, format: false
  
  resource :protected_pages, only: [:show], format: false

  devise_for :users
end
