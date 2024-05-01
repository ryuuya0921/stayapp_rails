class ReservationsController < ApplicationController

  def index
    @reservations = Reservation.includes(:room).all
  end

  def confirm
    @room = Room.find(params[:reservation][:room_id])  # 予約する部屋のIDからRoomオブジェクトを取得
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
  end

  def create
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @reservation.room = @room

    if @reservation.save
      redirect_to reservations_path, notice: '予約が確定されました。'  # 成功時はその部屋の詳細ページへリダイレクト
    else
      flash[:notice] = '予約が失敗しました。'
      render "rooms/show", status: :unprocessable_entity  # 失敗時は部屋の詳細ページを再表示
    end
  end

  def destroy
    @reservation = Reservation.find_by(id: params[:id])
    if @reservation
      @reservation.destroy
      redirect_to reservations_path, notice: '予約が正常に削除されました。'
    else
      redirect_to reservations_path, alert: '予約が見つかりませんでした。'
    end
  end
  
  private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :number_of_guests, :room_id)
  end
end