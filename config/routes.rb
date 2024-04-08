Rails.application.routes.draw do
  #HomeTopページ
  get '/' => 'pages#home'
  
  #User
  resources :events
  get '/users' => 'users#index'
  
end