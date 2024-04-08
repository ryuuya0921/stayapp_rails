Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  # ホームページ
  root 'pages#home'
  
  #Userページ
  resources :users
  get '/users/new', to: 'users#new' # ユーザー登録フォームの表示

end