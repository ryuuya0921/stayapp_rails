class RoomsController < ApplicationController

  def index
    @rooms = Room.all
  end

  def new
    @room  = Room.new
  end

  def show
    @room  = Room.find(params[:id])
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to confirm_room_path(@room),notice: '施設が正常に登録されました。'
    else
      render :new
    end
  end

  def confirm #予約確認
    @room = Room.find(params[:id])
  end

  def finalize_reservation
    @room = Room.find(params[:id])
    # 予約の確定処理をここに書く
    redirect_to root_path, notice: '予約が完了しました！'
  end
  
    private
  
  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image)
  end
  
end
