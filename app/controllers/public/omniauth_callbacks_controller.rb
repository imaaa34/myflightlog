# frozen_string_literal: true

class Public::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    @omniauth = request.env['omniauth.auth'] # 環境変数を取得して代入
    info = User.find_oauth(@omniauth) # user.rbに定義
    @user = info[:user]

    # persisted?でユーザ情報がDBに保存済みかチェックする
    if @user.persisted? # ユーザ登録済みなら新規登録ではなくログインする
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      @sns = info[:sns]
      render template: "devise/registrations/new"
    end
  end

  def failure # 認証が失敗したらトップ画面に戻る
    redirect_to(root_path) && return
  end
end
