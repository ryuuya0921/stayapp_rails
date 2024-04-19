class RoomsController < ApplicationController

  before_action :require_login, except: [:index, :show]

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
      # 保存が成功した場合の処理
      redirect_to @room, notice: "施設が正常に登録されました。"
    else
        # 保存が失敗した場合の処理
      render 'new'
    end
  end
  
    private
  
  def room_params
    params.require(:room).permit(:name)
  end
  
end
