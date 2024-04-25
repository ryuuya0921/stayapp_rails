class ReservationsController < ApplicationController

  def index
    @reservations = Reservation.includes(:room).all
  end

  def confirm
    @room = Room.find_by(id: params[:id])
    unless @room
      redirect_to rooms_path, alert: "指定された部屋が存在しません。"
      return
    end
  
    @check_in = params[:check_in]
    @check_out = params[:check_out]
    @number_of_guests = params[:number_of_guests]
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
