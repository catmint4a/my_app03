class StaticPagesController < ApplicationController

  def home
    head 200
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page]).search(params[:search])
    end
  end
  
  def help
  end

  def about
  end

  def new_guest
    user = User.find_or_create_by!(name: "guestuser", email: "guest@example.com") do |user|
      user.password = "password"
      user.password_confirmation = "password"
      # user.password = SecureRandom.alphanumeric
      # user.password_confirmation = user.password
    end
    log_in user
    users = User.all
    user = current_user
    # following = users[2..35]
    # followers = users[3..36]
    # following.each { |followed| user.follow(followed) }
    # followers.each { |follower| follower.follow(user) }
    # 50.times do
    #   content = Faker::Lorem.sentence(word_count: 5)
    #   user.microposts.create!(content: content)
    # end
    flash[:success] = "ゲストユーザーとしてログインしました。"
    redirect_to root_path
  end
end
