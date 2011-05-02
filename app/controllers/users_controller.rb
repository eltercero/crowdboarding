class UsersController < ApplicationController
  # GET /events
  def index
    @users = User.page(params[:page]).per(10)
  end
  
  # GET /events/1
  def show
    @user = User.find(params[:id])
  end
end