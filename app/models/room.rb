class Room < ApplicationRecord
  #料金が0円未満の場合はモデルが無効になり、データベースに保存されなくなる
  validates :price, numericality: { greater_than: 0, message: "は0円より大きい必要があります" }
  has_one_attached :image
  has_many :reservations, dependent: :destroy
end
