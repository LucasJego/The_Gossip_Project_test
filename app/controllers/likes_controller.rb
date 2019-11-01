class LikesController < ApplicationController
  def create
  	like = Like.new(user_id: current_user.id, potin_id: params[:format])
  	like.save
  	flash[:like] = "Liked"
  	redirect_to root_path
  end

  def destroy
  	@like = Like.find_by(user_id: current_user.id, potin_id: params[:id])
  	@like.destroy
  	flash[:unlike] = "Unliked"
  	redirect_to root_path
  end
end
