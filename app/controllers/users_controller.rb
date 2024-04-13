class UsersController < ApplicationController

  before_action :require_login, only: [:show, :account_settings, :profile_settings, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save

      flash[:notice] = 'ユーザーが作成されました'
      redirect_to users_path

    else
      render :new
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to root_path
  end

  #アカウント/プロフィール設定
  def account_settings
    @user = current_user
  end

  def profile_settings
    @user = current_user
  end

  #ユーザー編集
  def edit
    @user = current_user
  end

  def update_account_settings
    @user = current_user
  
    if @user.authenticate(params[:current_password]) && @user.update(user_params)
      flash[:notice] = '設定が更新されました'
      redirect_to root_path # 更新後にホームページにリダイレクト
    else
      flash.now[:alert] = '現在のパスワードが間違っています'
      render :edit # 現在のパスワードが間違っているため、編集ページにリダイレクト
    end
  end

  def update_password #パスワード変更用
    @user = current_user
  
    if @user.authenticate(params[:current_password]) && @user.update(password_params)
      flash[:notice] = 'パスワードが更新されました'
      redirect_to root_path
    else
      flash.now[:alert] = 'パスワードの更新に失敗しました'
      render :edit
    end
  end
  
  

  private

  def require_login
    unless logged_in?
      flash[:alert] = "ログインしてください"
      redirect_to login_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio, :profile_picture)
  end  
end
