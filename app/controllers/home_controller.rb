class HomeController < ApplicationController
  def index
    @events = Event.from_now.recent.page(params[:page]).per(10)
    @events_from_now = Event.from_now.limit(5)
    @active_users = User.limit(10)
    @tags = Event.tag_counts_on(:tags)
  end
end