Planning::Application.routes.draw do

  resources :sessions, :only => [:create, :new]
  resources :users, :only => [:create, :new]
  resources :events

  root :to => 'home#index'

  get '/logout/' => "sessions#logout", :as => 'logout'

  # get '/events/:slug' => 'events#show', :as => 'event'

  get '/users/:slug/admin' => 'users#admin', :as => 'admin'
  get '/users/:slug/profile' => 'users#profile', :as => 'profile'

end
