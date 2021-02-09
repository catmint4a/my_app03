class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find_by(params[:name])
  end

end
