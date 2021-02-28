class User < ApplicationRecord
  attr_accessor :remember_token, :reset_token
  has_many :microposts, dependent: :destroy
  before_save  { email.downcase! }
  VALID_NAME_REGEX = /\A[a-zA-Z0-9]+\z/i
  validates :name,  presence: true,
                    uniqueness: true,
                    length: { maximum: 50 },
                    format: { with: VALID_NAME_REGEX }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: true,
                    format:{ with: VALID_EMAIL_REGEX }
  has_secure_password
  VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i
  validates :password, presence: true, length: {minimum: 8 },
                       format: { with: VALID_PASSWORD_REGEX }

  def to_param
    name
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    mail = UserMailer.password_reset(self)
    mail.transport_encoding = "8bit"
    mail.deliver_now
  end

  def password_reset_expired?
    self.reset_sent_at < 2.hours.ago
  end
end
