class HomeController < ApplicationController
  def index
    @events = Event.recent.page(params[:page]).per(10)
  end
end