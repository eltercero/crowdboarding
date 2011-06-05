class UsersController < ApplicationController
  load_and_authorize_resource
  
  # GET /notifications
  def index
    @notifications = current_user.notifications.page(params[:page]).per(10)
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end