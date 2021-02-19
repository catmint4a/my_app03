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
    # if @user.update(user_params)
    #   # 更新に成功した場合を扱う。
    # else
    #   render 'edit'
    # end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
