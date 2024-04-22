class ReservationsController < ApplicationController

  def index
    @reservations = Reservation.includes(:room).all
  end

  def confirm #予約確認
    @room = Room.find(params[:id])

    @check_in = params[:check_in]
    @check_out = params[:check_out]
    @number_of_guests = params[:number_of_guests]
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to @reservation, notice: '予約が完了しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :number_of_guests, :room_id)
  end
end
