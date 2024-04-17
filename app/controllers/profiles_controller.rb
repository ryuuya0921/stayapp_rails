class ProfilesController < ApplicationController
  def edit_profile
    @user = current_user
  end


  def update_profile
    @user = current_user

    if @user.update(user_params)
      flash[:notice] = 'プロフィールが更新されました'
      redirect_to root_path
    else
      flash.now[:alert] = 'プロフィールの更新に失敗しました'
      render :edit_profile
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction)
  end
end
