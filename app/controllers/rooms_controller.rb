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

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to rooms_path, notice: '施設情報が正常に更新されました。'
    else
      render :edit
    end
  end
  
  def destroy
    @room = Room.find_by(id: params[:id])
    if @room
      @room.destroy
      redirect_to rooms_path, notice: '施設が正常に削除されました。'
    else
      redirect_to rooms_path, alert: '施設が見つかりませんでした。'
    end
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
  
  def set_room
      @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image)
  end
  
end
