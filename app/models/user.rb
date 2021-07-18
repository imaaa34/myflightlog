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
    super && (self.is_valid == true)
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

	#SNS認証
	#ユーザ登録していなければサインアップ
  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first

    if user.present?
      sns = SnsCredential.create(
        uid: auth.uid,
        provider: auth.provider,
        user_id: user.id
      )
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
    return { user: user ,sns: sns}
  end

  def self.with_sns_data(auth, snscredential)
    user = User.where(id: snscredential.user_id).first
    unless user.present?
      user = User.create(
        name: auth.info.name,
        email: auth.info.email,
        password: Devise.friendly_token.first(7)
      )
    end
    return {user: user}
  end

  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = with_sns_data(auth, snscredential)[:user]
      sns = snscredential
    else
      data = without_sns_data(auth)
      user = data[:user]
      sns = data[:sns]
    end
    return { user: user ,sns: sns}
  end

end
