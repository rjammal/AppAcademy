Rails.application.routes.draw do
  root to: 'users#new'
  resources :users
  resource :session, only: [:new, :create, :destroy]

  resources :bands do
    resources :albums, only: [:new, :create, :index], on: :collection
  end
  resources :albums, only: [:show, :destroy, :edit, :update] do
    resources :tracks, only: [:new, :create, :index], on: :collection
  end
  resources :tracks, only: [:show, :destroy, :edit, :update]
end
