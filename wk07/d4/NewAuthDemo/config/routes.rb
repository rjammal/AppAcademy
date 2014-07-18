NewAuthDemo::Application.routes.draw do
  get 'pages/home'

  get 'pages/contact'

  get 'pages/about'

  resources :users, :only => [:create, :new, :show]
  resource :session, :only => [:create, :destroy, :new]

  root :to => "users#show"
end
