class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  def show
  end

  def unsubscribe
  end

  def withdraw
  end

  def edit
  end

  private

    def set_current_user
      @user = current_user
    end

end
