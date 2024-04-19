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
end
