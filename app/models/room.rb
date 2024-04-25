class Room < ApplicationRecord
  #料金が0円未満の場合はモデルが無効になり、データベースに保存されなくなる
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  has_one_attached :image
  has_many :reservations, dependent: :destroy
end
