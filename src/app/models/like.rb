class Like < ApplicationRecord
  validates :micropost_id, presence: true
  validates :user_id, presence: true
  validates :micropost_id, uniqueness: { scope: :user_id }
  # belongs_to :user, dependent: :destroy
  # belongs_to :micropost, dependent: :destroy
end
