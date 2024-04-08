class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save

      flash[:notice] = 'イベントが作成されました'
      redirect_to users_path

    else
      render :new
    end

  end

  def destroy

  end
  
end
