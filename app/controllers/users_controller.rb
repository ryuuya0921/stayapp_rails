class UsersController < ApplicationController

  def index
    @users = User.all
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

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
