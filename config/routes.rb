Rails.application.routes.draw do

  get '/' => 'safe_locations#index'
  get '/safe_locations' => 'safe_locations#index'
  get '/safe_locations/new' => 'safe_locations#new'
  post '/safe_locations' => 'safe_locations#create'
  get '/safe_locations/:id' => 'safe_locations#show'
  get '/safe_locations/:id/edit' => 'safe_locations#edit'
  post '/safe_locations/:id' => 'safe_locations#update'
  delete '/safe_locations/:id' => 'safe_locations#destroy'

  get '/emergencies/new' => 'emergencies#new'
  post '/emergencies' => 'emergencies#create'
  get '/emergencies/:id' => 'emergencies#show'
  get '/emergencies/:id/edit' => 'emergencies#edit'
  post '/emergencies/:id' => 'emergencies#update'
  delete '/emergencies/:id' => 'emergencies#destroy'
  
  get '/events/new' => 'events#new'
  post '/events' => 'events#create'
  get '/events/:id' => 'events#show'
  get '/events/:id/edit' => 'events#edit'
  post '/events/:id' => 'events#update'
  delete '/events/:id' => 'events#destroy'
  
  get '/services/new' => 'relief_services#new'
  post '/services' => 'relief_services#create'
  get '/services/:id' => 'relief_services#show'
  get '/services/:id/edit' => 'relief_services#edit'
  post '/services/:id' => 'relief_services#update'
  delete '/services/:id' => 'relief_services#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  get '/users/:id' => 'users#show'
  get '/users/:id/edit' => 'users#edit'
  post '/users/:id' => 'users#update'
  delete '/users/:id' => 'users#destroy'  

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

end
