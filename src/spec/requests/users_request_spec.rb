require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    @user = User.new(
    name: "Aaron2",
    email: "tester2@example.com",
    password: "password",
    password_confirmation: "password",
    admin: false
    )
    @user.save

    @user2 = User.new(
    name: "taro2",
    email: "taro2@example.com",
    password: "password",
    password_confirmation: "password",
    admin: true
    )
    @user2.save
  end
  describe "GET /signup" do
    it "returns http success" do
      get "/signup"
      expect(response).to have_http_status(:success)
    end
  end
  describe "link in home with login" do
    before do
      30.times do
        @users = FactoryBot.create(:users)
      end
      @user = FactoryBot.create(:user)
      sign_in_as @user
    end
    it "show index include pagination" do
      visit users_path
      expect(page).to have_css ".pagination"
    end
  end
  describe "users page not login user" do
    it "returns http success" do
      get "/users"
      expect(response).to have_http_status(302)
    end
    it "returns http success" do
      visit "/users"
      expect(page).to_not have_content("#{@user.name}")
    end
  end
  describe "admin param" do
    it "is not allow the admin attribute to be edited via the web" do
      patch "/users/#{@user.name}", params: { 
                                  user: {
                                  password:              "password",
                                  password_confirmation: "password",
                                  admin: false } }
      expect(@user.reload.admin).to be_falsey
    end
  end

  describe "before_action: :logged_in_user" do
    it 'redirects following when not logged in' do
      get following_user_path(@user)
      expect(response).to redirect_to login_url
    end

    it 'redirects followers when not logged in' do
      get followers_user_path(@user)
      expect(response).to redirect_to login_url
    end
  end
end
