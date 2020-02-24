Rails.application.routes.draw do

  resources :articles
  resources :comments
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
        get '/login', to: 'sessions#create'
        post '/logout', to: 'sessions#destroy'
        get '/getuser', to: 'users#retrieve_user'
        get '/profile/:id', to: 'users#show'
        patch '/profile/:id', to: 'users#update'
        post '/login', to: 'sessions#create'
        post '/googleAuth', to: 'sessions#google'
        post '/signup', to: 'users#create'
        get '/preferences', to: 'users#preferences'
    end 
  end 
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
