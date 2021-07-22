class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:edit, :update]

  def index
    @users = User.all.page(params[:page]).per(5)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admins_users_path, notice: 'ユーザ情報を更新しました。'
    else
      render :edit
    end
  end

  def search
    @word = params[:word]
    @users = User.looks(@word)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :is_valid)
  end
end
