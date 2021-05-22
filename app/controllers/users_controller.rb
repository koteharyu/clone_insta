class UsersController < ApplicationController
  skip_before_action :require_login

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)
    if @user.save
      auto_login(@user)
      redirect_to login_path, success: 'ユーザーを作成しました'
    else
      flash.now[:danger] = "ユーザーの作成に失敗しました"
      render :new
    end
  end

  private
  def params_user
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
