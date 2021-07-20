class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :logs, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :sns_credentials, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true

  # is_validカラムがtrueであるか
  def active_for_authentication?
    super && (is_valid == true)
  end

  # ユーザ検索機能
  def self.looks(word)
    @users = User.where(["name LIKE? OR email LIKE?", "%#{word}%", "%#{word}%"])
  end

  # ゲストログイン機能
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲスト'
    end
  end

  # SNS認証機能
  # SNS情報がない場合
  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first

    # userが存在していたら、sns_credentialを作成＆保存
    if user.present?
      sns = SnsCredential.create(
        uid: auth.uid,
        provider: auth.provider,
        user_id: user.id
      )
    # userが存在していなければ、userとsns_credentialを作成＆保存
    else
      user = User.create(
        name: auth.info.name,
        email: auth.info.email,
        password: Devise.friendly_token.first(7)
      )
      sns = SnsCredential.create(
        user_id: user.id,
        uid: auth.uid,
        provider: auth.provider
      )
    end
    { user: user, sns: sns }
  end

  # SNS情報がある場合
  def self.with_sns_data(auth, snscredential)
    user = User.where(id: snscredential.user_id).first

    # userが存在しなければ、認証情報からuserを作成＆保存
    if user.blank?
      user = User.create(
        name: auth.info.name,
        email: auth.info.email,
        password: Devise.friendly_token.first(7)
      )
    end
    { user: user }
  end

  def self.find_oauth(auth)
    uid = auth.uid # ログインユーザー識別用IDをuidに代入
    provider = auth.provider # ログインに使用したプロバイダー名をproviderに代入
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = with_sns_data(auth, snscredential)[:user]
      sns = snscredential
    else
      data = without_sns_data(auth)
      user = data[:user]
      sns = data[:sns]
    end
    { user: user, sns: sns }
  end
end
