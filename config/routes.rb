Rails.application.routes.draw do

  resources :articles
        get '/bookmarks/:user_id', to: 'articles#bookmarks' 
        put '/bookmarks/:id/:user_id', to: 'articles#remove'
        post '/bookmarks', to: 'articles#create_bookmark'
  
  resources :comments
        post '/comments', to: 'comments#create'
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
        post '/facebookAuth', to: 'sessions#facebook'
        post '/signup', to: 'users#create'
        get '/preferences', to: 'users#preferences'
    end 
  end 
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
