class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(name: params[:name])
    end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "登録ありがとうございます！"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find_by(name: params[:name])
  end

  def update
    @user = User.find_by(name: params[:name])
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を変更しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
