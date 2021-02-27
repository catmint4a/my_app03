class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def edit
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "パスワード再設定用のメールを送信しました"
      redirect_to root_url
    else
      flash.now[:danger] = "入力されたメールアドレスを見つけることができませんでした"
      render "new"
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render "edit"      
    elsif @user.update(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "パスワードを再設定しました"
      redirect_to @user
    else
      render "edit"            
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
      logger.debug("[debug]get_user #{(@user && @user.authenticated?(:reset, params[:id]))}")
      logger.debug("[debug]get_user #{@user}")
    end

    def valid_user
      logger.debug("[debug] #{(@user && @user.authenticated?(:reset, params[:id]))}")
      logger.debug("[debug] #{@user}")
      # logger.debug("[debug] #{(@user.authenticated?(:reset, params[:id]))}")
      unless (@user && @user.authenticated?(:reset, params[:id]))
        flash[:danger] = "ユーザーは有効ではありません"
        redirect_to root_url
      end 
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "パスワードリセットの有効期限は切れました\nリセット用のメールを再取得してください"
        redirect_to new_password_reset_url
      end
    end
end
