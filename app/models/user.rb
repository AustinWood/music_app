# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  attr_reader :password

  after_initialize :ensure_session_token

  validates :password_digest, presence: true
  validates :password, length: { minimum: 2, allow_nil: true }

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    puts "USER NOT NIL"
    return nil if user.nil?
    if user.is_password?(password)
      puts "PASSWORD MATCH"
      return user
    else
      puts "PASSWORD NIL"
      return nil
    end
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
     self.session_token = User.generate_session_token
     self.save!
     self.session_token
  end

  private
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
