class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "ログインに成功しました"
      redirect_to users_path  # ログイン後に遷移するページを指定する
    else
      flash.now[:alert] = "ログインに失敗しました"
      render :new
    end
  end

  def destroy
  end
end
