Planning::Application.routes.draw do

  resources :sessions, :only => [:create, :new, :destroy]
  resources :users, :only => [:create, :new]

  root :to => 'home#index'

  get '/events/:slug' => 'events#show', :as => 'event'

  get '/users/:slug/admin' => 'users#admin', :as => 'admin'
  get '/users/:slug/profile' => 'users#profile', :as => 'profile'

end