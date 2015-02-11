class User < ActiveRecord::Base
  validates(:user_name,
            :password_digest,
            :session_token,
            presence: true)
  validates :session_token, uniqueness: true
  validates :password, length: {minimum: 8}, allow_nil: true

  def self.find_by_credentials(user_name, password)
    @user = User.find_by(user_name: user_name)
    return nil unless @user && @user.is_password?(password)
    @user
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64

    self.save
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)

    # self.save
  end

  def password
    @password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
