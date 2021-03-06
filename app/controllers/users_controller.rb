class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]
  before_action :require_authorization

  def new
    render "new"
  end

  def show
    @user = User.find(params[:id])
    render "show"
  end

  def edit
    @user = User.find(params[:id])
    render "edit"
  end

  def create
    @user = User.new user_params
    if @user.valid?
      @user.save
      redirect_to "/sessions/new"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to"/users/new"
    end
  end


  def update
    @user = User.find(params[:id])
    if @user.update user_params
      redirect_to "/users/#{@user.id}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to"/users/#{@user.id}/edit"
    end
  end


  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      reset_session
      redirect_to "/users/new"
    else
      redirect_to "/users/#{@user.id}/edit"
    end  
  end

  private
    def user_params 
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
