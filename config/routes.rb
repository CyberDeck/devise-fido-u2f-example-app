Rails.application.routes.draw do
  get 'pages/:id', to: 'pages#show', as: :page, format: false
  root to: 'pages#show', id: 'home'

  devise_for :users
end
