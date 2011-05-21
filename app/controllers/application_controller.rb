class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_local
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  
  def change_local
    session[:local] = params[:local]
    redirect_to :back
  end
  
  private
  
  def set_local
    I18n.locale = session[:local] if session[:local]
  end
end
