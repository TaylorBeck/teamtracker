class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery

  private
  def require_login
    if !logged_in?
      redirect_to('/')
      flash[:notice] = "Please login or register before continuing."
    end
  end
end
