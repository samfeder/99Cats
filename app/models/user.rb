class User < ActiveRecord::Base
  attr_reader :password

  validates :username, presence: :true
  validates :password_digest, presence: {message: "Password can't be blank"}
  validates :username, length: { minimum: 8 }
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :username, uniqueness: true

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
end
