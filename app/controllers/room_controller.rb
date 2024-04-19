class RoomController < ApplicationController

  def index
    @rooms = Room.all
  end

  def new
    @rooms  = Room.new
  end

  def show
    @rooms  = Room.find(params[:id])
  end
end
