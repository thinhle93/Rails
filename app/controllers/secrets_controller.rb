class SecretsController < ApplicationController
  def index
    @secrets = Secret.all
    user = User.find(session[:userid])
    @secrets_liked_ids = user.secrets_liked_ids
  end

  def create
    
    Secret.create(content:params[:Content], user: User.find(params[:userid]))
    redirect_to "/users/#{params[:userid]}"
  end

  def delete
    Secret.find(params[:id]).destroy
    redirect_to "/users/#{session[:userid]}"
  end
end
