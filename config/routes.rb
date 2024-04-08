Rails.application.routes.draw do
  # ホームページ
  root 'pages#home'
  
  #Userページ
  resources :users
  get "/user" => 'users#index'
end