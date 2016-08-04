class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_filter :require_signin

  private
  def require_signin
    unless current_user
      redirect_to signin_path
    end
  end
end
