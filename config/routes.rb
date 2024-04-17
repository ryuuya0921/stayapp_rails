Rails.application.routes.draw do

  get 'profiles/edit_profile'
  # ホームページ
  root 'pages#home'

  # ユーザー関連
  # resources :users, except: [:new] do
  #   member do
  #     get 'account_settings' # アカウント設定ページ
  #     get 'profile_settings' # プロフィール設定ページ
  #     get 'edit' # 編集ページ
  #     patch 'account_settings', to: 'users#update_account_settings'
  #     patch 'update_password', to: 'users#update_password', on: :collection
  #   end
  # end

# config/routes.rb

  resources :users do
    get 'edit', on: :member # 編集ページ
    get 'account_settings', on: :member # アカウント設定ページ
    patch 'update_account_settings', on: :member # アカウント設定の更新
    patch 'update_password', on: :member # パスワードの更新
    get 'profile_settings', on: :member # プロフィール設定ページ

  end

  resources :users do
    get 'profile_settings', on: :member
    get 'edit_profile', on: :member
  end

  resources :users do
    get 'profile_settings', on: :member
  end

get '/profiles/:id/edit', to: 'profiles#edit_profile', as: 'edit_profile'
patch '/profiles/:id/update_profile', to: 'profiles#update_profile', as: 'update_profile'


  resources :users
  get '/users/new', to: 'users#new' # 新規登録ページへのルートを追加

  # Sessions
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy' # ログアウトのルートを追加
  
end