class User < ApplicationRecord
  before_save  { email.downcase! }
  VALID_NAME_REGEX = /\A[a-z0-9]+\z/i
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
end
