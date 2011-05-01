class RidersController < ApplicationController
  # GET /events
  def index
    @riders = User.page(params[:page]).per(10)
  end
  
  # GET /events/1
  def show
    @rider = User.find(params[:id])
  end
end