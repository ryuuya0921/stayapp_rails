class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in, :check_out, :number_of_guests, :room_id, presence: true
  validates :number_of_guests, numericality: { greater_than: 0, only_integer: true }

  validate :check_in_cannot_be_in_the_past
  validate :check_out_after_check_in
  
  # 予約の日数を計算
  def total_days
    (check_out - check_in).to_i if valid_dates?
  end

  # 支払い総額を計算
  def total_price
    if valid_dates?
      total_days * room.price * number_of_guests
    else
      0
    end
  end

  def calculate_total_price
    # 合計料金を再計算するロジックを実装する
    # 例えば、チェックイン日、チェックアウト日、料金などを元に合計料金を計算する
    # この例では、仮のロジックとして、1泊あたりの料金を部屋の料金から計算していますが、実際のロジックに合わせて修正してください
    if valid_dates?
      self.total_price = total_days * room.price * number_of_guests
      save
    else
      self.total_price = 0
    end
  end

  def total_price=(price)
    self[:total_price] = price
  end

  # 日付が有効かどうかを確認するメソッド
  def valid_dates?
    check_in && check_out && check_out > check_in
  end

    private

    # チェックインが今日以降であることを確認
    def check_in_cannot_be_in_the_past
      if check_in.present? && check_in < Date.today
        errors.add(:check_in, "は過去の日付に設定できません。")
      end
    end

    # チェックアウトがチェックイン日より後であることを確認
    def check_out_after_check_in
      if check_out.present? && check_in.present? && check_out <= check_in
        errors.add(:check_out, "はチェックイン日より後の日付でなければなりません。")
      end
    end

end

