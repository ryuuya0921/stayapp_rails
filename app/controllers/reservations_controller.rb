class ReservationsController < ApplicationController

  def index
    @reservations = Reservation.includes(:room).all
  end


end
