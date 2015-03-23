class User < ActiveRecord::Base
  validates(
    :email,
    :password_digest,
    :session_token,
    :activation_token,
    presence: true
  )

  validates :email, uniqueness: true, length: {minimum: 8}
  validates :session_token, :activation_token, uniqueness: true
  after_initialize :ensure_session_token, :ensure_activation_token

  has_many(
    :notes,
    class_name: "Note",
    foreign_key: :user_id,
    primary_key: :id
  )

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end


  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil if user.nil? || !user.is_password?(password)
    user
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def make_admin!
    self.admin = true
    self.save
  end

  private

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def ensure_activation_token
    self.activation_token ||= User.generate_session_token
  end
end
