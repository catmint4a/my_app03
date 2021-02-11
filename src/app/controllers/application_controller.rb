class ApplicationController < ActionController::Base
  include SessionsHelper
  # before_action :current_user?

  # private
  # def logged_in?
  #   if current_user
  #     @user = current_user
  #   end
  # end
end
