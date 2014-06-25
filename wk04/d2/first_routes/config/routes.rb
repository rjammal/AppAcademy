Rails.application.routes.draw do
  resources :users, except: [:new, :edit] do
    get "favorites", on: :member
    
    resources :contacts, only: :index do
      patch "favorite", on: :member
    end
    
    resources :comments, only: :index
    
  end
  
  resources :contacts, except: [:new, :edit, :index] do
    resources :comments, only: :index
  end
  
  resources :contact_shares, only: [:destroy, :create]
  resources :comments, only: [:destroy, :create]
end
