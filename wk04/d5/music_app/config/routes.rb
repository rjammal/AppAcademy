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
  resources :tracks, only: [:show, :destroy, :edit, :update] do
    member do 
      post '/new_note', to: 'track#new_note'
      patch '/edit_note/:note_id', to: 'track#edit_note'
      delete '/delete/:note_id', to: 'track#destroy_note', as: :destroy_note
    end
  end
end
