class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]


  def new
    # render login page
    render "new"
  end

  def create
    # Log User In
    # if authenticate true
        # save user id to session
        # redirect to users profile page
    # if authenticate false
        # add an error message -> flash[:errors] = ["Invalid"]
        # redirect to login page
      @user = User.find_by_email(params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to "/users/#{@user.id}"
      else
        flash[:errors] = ["Invalid Combination"]
        redirect_to "/sessions/new"
      end
  end
  
  def destroy
    # Log User out
    # set session[:user_id] to null
    # redirect to login page
    reset_session
    redirect_to "/sessions/new" 
  end
end
