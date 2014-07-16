Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    resources :posts, :only => [:create, :index, :show, :update, :destroy]
  end
  
  root to: 'static#root'
end
