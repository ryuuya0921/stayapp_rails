Rails.application.routes.draw do

  get 'profiles/edit_profile'
  # ホームページ
  root 'pages#home'

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

  resources :users, only: [:show]#画像UP
  

resources :profiles, only: [:edit, :update]#テスト
patch '/profiles/:id', to: 'profiles#create_or_update_profile', as: 'create_or_update_profile'


patch '/profiles/:id/update_profile', to: 'profiles#create_or_update_profile', as: 'update_profile'


  resources :users
  get '/users/new', to: 'users#new' # 新規登録ページへのルートを追加

  # Sessions
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy' # ログアウトのルートを追加

  #Room
  # resources :rooms do
  #   member do
  #     get 'confirm'
  #     post 'confirm' 
  #     post 'finalize_reservation'
  #   end
  # end

  resources :rooms do
    resources :reservations do
      member do
        get 'confirm'
        post 'confirm'  # これは例えば、各予約に対しての確認アクションを意味します
      end
    end
  end
  
  #reservation
  resources :reservations do
    member do

    end
  end

end