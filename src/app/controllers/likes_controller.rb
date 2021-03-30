class LikesController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user

  def create
    @micropost = Micropost.find(params[:id])
    @like = Like.new(
      user_id: @current_user.id,
      micropost_id: params[:id],
    )
    @like.save
    respond_to do |format|
      format.html { redirect_to @current_user }
      format.js
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @like = Like.find_by(
      user_id: @current_user.id,
      micropost_id: params[:id],
    )
    @like.destroy
    respond_to do |format|
      format.html { redirect_to @current_user }
      format.js
    end
  end
end