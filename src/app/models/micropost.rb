class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image , content_type: { in: %W[image/jpeg image/gif image/png],
                                    message: "有効な画像ファイルを指定してください" },
                            size: { less_than: 5.megabytes,
                                    message: "画像は5MB以下のものを指定してください"}

  def display_image
    begin
      image.variant(resize_to_limit: [500, 500])      
    rescue => exception      
      return image
    end
  end

  def self.search(search)
    if search
      where(['content LIKE ?', "%#{search}%"])
    else
      Micropost.all
    end
  end
end
