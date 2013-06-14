Planning::Application.routes.draw do

  resources :sessions, :only => [:create, :new]
  resources :events
  resources :users
  resources :conditions

  root :to => 'home#index'

  get '/logout/' => "sessions#logout", :as => 'logout'

  get '/users/:slug/admin' => 'users#admin', :as => 'admin'
  get '/users/:slug/profile' => 'users#profile', :as => 'profile'

end
