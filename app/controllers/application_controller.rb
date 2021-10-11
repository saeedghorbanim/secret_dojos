class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_action :require_login
  
  private
  
  def require_login
    redirect_to "/sessions/new" unless session[:user_id]
  end


  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    else
      nil
    end
  end

  def require_authorization
    redirect_to "/users/#{current_user.id}" current_user.id == params[:id].to_i
  end
  
  helper_method :current_user
end

