class Like < ApplicationRecord
  validates :micropost_id, presence: true
  validates :user_id, presence: true
  validates :micropost_id, uniqueness: { scope: :user_id }
end
