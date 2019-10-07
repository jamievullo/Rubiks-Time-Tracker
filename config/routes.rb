Rails.application.routes.draw do

  root 'sessions#home'
  get '/signup' => 'cubers#new'
  post '/signup' => 'cubers#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  
  resources :cubers 
  resources :cube_times
  
end