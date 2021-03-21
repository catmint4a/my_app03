class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy,
                                        :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    if User.find_by(name: params[:name])
      @user = User.find_by(name: params[:name])
      @microposts = @user.microposts.paginate(page: params[:page])
    else
      flash[:danger] = "ページが存在しません"
      redirect_to root_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "登録ありがとうございます！"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find_by(name: params[:name])
  end

  def update
    @user = User.find_by(name: params[:name])
    @user.image.attach(params[:user][:image])
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を変更しました"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    User.find_by(name: params[:name]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_path
  end

  def following
    @title = "フォロー"
    @user = User.find_by(name: params[:name])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find_by(name: params[:name])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :image, :user_name,
                                   :profile, :password_confirmation)
    end

    def correct_user
      @user = User.find_by(name: params[:name])
      redirect_to (root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
