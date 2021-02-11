class StaticPagesController < ApplicationController

  def home
    if current_user
      @user = current_user
    end
  end
  
  def help
  end

  def about
  end
end
