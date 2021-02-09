class User < ApplicationRecord
  before_save  { email.downcase! }
  validates :name,  presence: true,
                    uniqueness: true,
                    length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: true,
                    format:{ with: VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true, length: {minimum: 8 }

  # def to_param
  #   name
  # end
end
