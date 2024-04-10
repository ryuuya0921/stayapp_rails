Rails.application.routes.draw do

  # ホームページ
  root 'pages#home'

  
  #Userページ
  resources :users
  get '/users/new', to: 'users#new' # ユーザー登録フォームの表示

  #Sessions
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy' # ログアウトのルートを追加
  
end