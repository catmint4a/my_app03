class StaticPagesController < ApplicationController

  def home
    @micropost = current_user.microposts.build if logged_in?
    @feed_items = current_user.feed.paginate(page: params[:page])# if current_user.feed
  end
  
  def help
  end

  def about
  end
end
