class RidersController < ApplicationController
  def index
    @riders = User.page(params[:page]).per(10)
  end
end