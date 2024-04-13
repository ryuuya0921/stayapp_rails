Rails.application.routes.draw do

  # ホームページ
  root 'pages#home'

  # ユーザー関連
  resources :users, except: [:new] do
    member do
      get 'account_settings' # アカウント設定ページ
      get 'profile_settings' # プロフィール設定ページ
    end
  end

  #Sessions
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy' # ログアウトのルートを追加
  
end