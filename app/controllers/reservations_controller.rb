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

    if @reservation.save
      redirect_to room_path(@room), notice: '予約が確定されました。'  # 成功時はその部屋の詳細ページへリダイレクト
      logger.debug "Reservation saved successfully."
    else
      logger.debug "Failed to save reservation: #{@reservation.errors.full_messages}"
      flash[:notice] = '予約が失敗しました。'
      render "rooms/show", status: :unprocessable_entity  # 失敗時は部屋の詳細ページを再表示
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to confirm_reservations_path, notice: '保存が完了しました。'
    else
      render :new
    end
  end
  

  private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :number_of_guests, :room_id)
  end
end
