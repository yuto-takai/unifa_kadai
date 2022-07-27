class PostedPhoto < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :image, presence: true
end
