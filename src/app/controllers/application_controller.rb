class ApplicationController < ActionController::Base
  include SessionsHelper
  # protect_from_forgery

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
end
