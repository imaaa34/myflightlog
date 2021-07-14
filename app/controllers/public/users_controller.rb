class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user
  before_action :check_guest, only: [:update, :withdraw]


  def show
  end

  def unsubscribe
  end

  def withdraw
    @user.update(is_valid: false)
    reset_session
    redirect_to root_path
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: 'ユーザ情報を更新しました。'
    else
      flash.now[:alert] = '更新できませんでした。'
      render :edit
    end
  end

  private

    def set_current_user
      @user = current_user
    end

    def check_guest
      if current_user.email == 'hoge@example.com'
        redirect_to user_path, alert: 'ゲストユーザーは更新・削除できません。'
      end
    end

    def user_params
      params.require(:user).permit(:name, :email)
    end

end
