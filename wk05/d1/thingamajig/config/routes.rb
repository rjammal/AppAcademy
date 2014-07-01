Rails.application.routes.draw do
  resource :session, only: [:create, :new, :destroy]
  resources :users, except: [:destroy, :index, :edit, :update]
  resource :user, only: [:edit]
  resource :user, only: [:update], as: :update_user
  resources :circles
  resources :posts, except: [:index, :destroy, :edit, :update]
  get "feed" => "posts#index"
end
