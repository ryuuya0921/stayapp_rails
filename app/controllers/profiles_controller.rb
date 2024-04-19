class ProfilesController < ApplicationController

  before_action :set_user, only: [:edit, :update]

  def edit
    @introduction = @user.introduction || ''
  end

  def update
    if @user.update(user_params_without_password)
      flash[:notice] = 'プロフィールが更新されました'
      redirect_to profile_settings_user_path(@user)
    else
      flash.now[:alert] = 'プロフィールの更新に失敗しました'
      render :edit
    end
  end
  
  
  private

  def set_user
    @user = current_user
  end
  
  # def user_params
  #   if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
  #     params.require(:user).permit(:name, :introduction)
  #   else
  #     params.require(:user).permit(:name, :introduction, :password, :password_confirmation, :avatar)
  #   end
  # end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar) # avatar を許可する
  end
  
  
  
  def user_params_without_password
    params_without_password = user_params.except(:password, :password_confirmation)
    params_without_password
  end
  
  
end

