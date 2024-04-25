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

  class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :room
  
    validates :check_in, :check_out, :number_of_guests, :room_id, presence: true
    validates :number_of_guests, numericality: { greater_than: 0, only_integer: true }
    validate :check_in_before_check_out, :check_in_in_the_future
  
    private
  
    # チェックインがチェックアウト前であることを確認
    def check_in_before_check_out
      return if check_in.blank? || check_out.blank?
      if check_in >= check_out
        errors.add(:check_in, 'must be before check-out date')
      end
    end
  
    # チェックインが未来の日付であることを確認
    def check_in_in_the_future
      return if check_in.blank?
      if check_in < Date.today
        errors.add(:check_in, 'must be in the future')
      end
    end
  end
  
end
