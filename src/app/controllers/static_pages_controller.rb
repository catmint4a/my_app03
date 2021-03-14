class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  
  def help
  end

  def about
  end

  def new_guest
    user = User.find_or_create_by!(name: 'guestuser', email: 'guest@example.com') do |user|
      user.password = SecureRandom.alphanumeric
      user.password_confirmation = user.password
    end
    log_in user
    flash[:success] = 'ゲストユーザーとしてログインしました。'
    redirect_to root_path
  end
end
