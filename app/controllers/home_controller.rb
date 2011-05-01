class HomeController < ApplicationController
  def index
    @events = Event.recent.page(params[:page]).per(10)
    @events_from_now = Event.from_now.limit(5)
    @active_riders = User.limit(10)
  end
end