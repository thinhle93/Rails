class LikesController < ApplicationController
  def create
    Like.create(user:User.find(session[:userid]), secret:Secret.find(params[:id]))
    redirect_to '/secrets'
  end

  def destroy
    Like.find_by(user:User.find(session[:userid]), secret:Secret.find(params[:id])).destroy
    redirect_to '/secrets'
  end
end
