class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_local
  
  def change_local
    session[:local] = params[:local]
    redirect_to :back
  end
  
  private
  
  def set_local
    I18n.locale = session[:local] if session[:local]
  end
end
