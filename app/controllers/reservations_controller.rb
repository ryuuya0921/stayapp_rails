class ReservationsController < ApplicationController

  def index
    @reservations = Reservation.includes(:room).all
  end

  def confirm
    @room = Room.find(params[:reservation][:room_id])  # 予約する部屋のIDからRoomオブジェクトを取得
    logger.debug "Room loaded: #{@room.inspect}"
    @reservation = Reservation.new(reservation_params)
    logger.debug "Reservation params: #{reservation_params.inspect}"
    @reservation.user = current_user
  end

  def create
    @room = Room.find(params[:reservation][:room_id]) # 予約された部屋のIDからRoomオブジェクトを取得
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @reservation.room = @room # 確実にRoomが設定されていることを保証

    if @reservation.save
      redirect_to confirm_room_reservation_path(@room, @reservation), notice: '予約が確定されました。'  # 成功時はその部屋の詳細ページへリダイレクト
      logger.debug "Reservation saved successfully."
    else
      flash[:notice] = '予約が失敗しました。'
      render "rooms/show", status: :unprocessable_entity  # 失敗時は部屋の詳細ページを再表示
    end

  end
  

  private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :number_of_guests, :user_id, :room_id)
  end
  

end
