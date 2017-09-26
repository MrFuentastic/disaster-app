Rails.application.routes.draw do

  get '/emergencies' => 'emergencies#index'
  get '/emergencies/new' => 'emergencies#new'
  post '/emergencies' => 'emergencies#create'
  get '/emergencies/:id' => 'emergencies#show'
  get '/emergencies/:id/edit' => 'emergencies#edit'
  post '/emergencies/:id' => 'emergencies#update'
  
  get '/services/new' => '/relief_services#new'
  post '/services' => '/relief_services#create'
  get '/services/:id' => '/relief_services#show'
  get '/services/:id/edit' => '/relief_services#edit'
  post '/services/:id' => '/relief_services#update'

end
