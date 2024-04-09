class UsersController < ApplicationController
  before_action :require_login, only: [:show]
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

  end

  private

  def require_login
    unless logged_in?
      flash[:alert] = "ログインしてください"
      redirect_to login_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
