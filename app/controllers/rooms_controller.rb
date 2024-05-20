class RoomsController < ApplicationController

  def index
    @rooms = Room.all
    
    if params[:search].present?
      @rooms = Room.where("address LIKE ?", "%#{params[:search]}%")
    else
      @rooms = Room.all
    end

  end

  def new
    @room  = Room.new
  end

  def show
    if params[:id] == "area"
      # "area"がparams[:id]に来た場合はエリア検索のページにリダイレクト
      redirect_to area_rooms_path(area: params[:search])
    else
      @room = Room.find_by(id: params[:id])
      if @room
        @reservation = Reservation.new
      else
        redirect_to root_path, alert: '部屋が見つかりませんでした。'
      end
    end
  end
  
  def area
    @area = params[:area]
    @rooms = Room.where("address LIKE ?", "%#{@area}%")
    render :index
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to room_path(@room), notice: '施設情報が正常に更新されました。'
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
      redirect_to room_path(@room), notice: '施設が正常に登録されました。'
    else
      render :new
      flash.now[:alert] = 'エラーが発生しました。入力内容を確認してください。'
    end
  end

  def create_reservation # 予約の作成と保存
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to room_path(@reservation.room), notice: '予約が完了しました。'
    else
      @room = Room.find(params[:room_id])  # 予約に失敗した場合、同じページに戻る
      render 'confirm', alert: '予約に失敗しました。入力内容を確認してください。'
    end
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

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :number_of_guests, :room_id)
  end
  
end
