class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery prepend: false
  before_action :require_signin
  before_action :set_locale

  private
  
  def require_signin
    redirect_to signin_path unless current_user and return
  end

  def user
    @user ||= current_user
  end
 
  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end
end
