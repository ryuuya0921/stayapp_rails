class AddTotalPriceToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :total_price, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
