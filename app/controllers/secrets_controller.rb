class SecretsController < ApplicationController
  def index
    @secrets = Secret.all
  end

  def create
    @secret = Secret.create secret_params
    if @secret.valid?
      redirect_to "/users/#{current_user.id}"
    else
      flash[:errors] = secret.errors.full_messages
      redirect_to :back
    end
  end



  def destroy
    @secret = Secret.find(params[:id])
    @secret.destroy if @secret.user === current_user
    redirect_to "/users/#{current_user.id}"
  end


  private
    def secret_params
      params.require(:secret).permit(:content).merge(user: current_user)
    end
end
