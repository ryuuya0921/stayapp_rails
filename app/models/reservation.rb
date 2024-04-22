class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in, :check_out, :number_of_guests, :room_id, presence: true
  
  # 予約の日数を計算
  def total_days
    if check_in && check_out
      (check_out - check_in).to_i
    else
      0  # あるいはエラーメッセージを返す
    end
  end

  # 支払い総額を計算
  def total_price
    total_days * room.price * number_of_guests
  end
end
