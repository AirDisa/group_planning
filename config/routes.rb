Planning::Application.routes.draw do

  resources :sessions, :only => [:create, :new]
  resources :events
  resources :users
  resources :conditions
  resources :comments

  root :to => 'home#index'

  get  '/logout/' => "sessions#logout", :as => 'logout'
  post '/invitees/:id' => "invitees#update", :as => 'update'
  get  '/users/:slug/admin' => 'users#admin', :as => 'admin'
  get  '/users/:slug/profile' => 'users#profile', :as => 'profile'
  post 'validate/email' => 'users#validate_email'

end
