class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true

  has_secure_password

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_token, User.digest(User.new_token))
  end

  def forget
    update_attribute(:remember_token, nil)
  end

  def authenticated?(attribute, token)
    user.send(attribute) == User.digest(token)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token)
  end
end
