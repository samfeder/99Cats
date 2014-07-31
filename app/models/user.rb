class User < ActiveRecord::Base
  attr_reader :password

  validates :username, presence: :true
  validates :password_digest, presence: {message: "Password can't be blank"}
  validates :username, length: { minimum: 8 }
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :username, uniqueness: true
  validates :session_token, presence: true
  after_initialize :ensure_session_token

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
