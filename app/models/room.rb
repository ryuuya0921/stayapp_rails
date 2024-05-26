class Room < ApplicationRecord
  #料金が0円未満の場合はモデルが無効になり、データベースに保存されなくなる
  validates :price, numericality: { greater_than: 0, message: "は0円より大きい必要があります" }
  validates :address, presence: { message: "を入力してください" } # 住所の必須バリデーション
  validates :description, presence: { message: "を入力してください" }
  validates :name, presence: { message: "を入力してください" }
  has_one_attached :image
  has_many :reservations, dependent: :destroy

    def total_price
      # 予約がある場合は、その合計金額を返す
      reservations.sum(&:total_price)
    end
end
