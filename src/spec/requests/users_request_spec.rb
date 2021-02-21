require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    @user = User.new(
    name: "Aaron",
    email: "tester@example.com",
    password: "password",
    password_confirmation: "password",
    )
    @user.save

    @user2 = User.new(
    name: "taro",
    email: "taro@example.com",
    password: "password",
    password_confirmation: "password",
    )
    @user2.save
  end

  describe "GET /signup" do
    it "returns http success" do
      get "/signup"
      expect(response).to have_http_status(:success)
    end
  end
  describe "users page as login user" do
    before do
      sign_in_as(@user)
    end
    it "returns http success" do
      visit "/users"
      find_link("#{@user.name}")
    end
    it "returns http success" do
      visit "/users"
      find_link("#{@user2.name}")
    end
  end
  describe "users page as login user" do
    it "returns http success" do
      get "/users"
      expect(response).to have_http_status(302)
    end
    it "returns http success" do
      visit "/users"
      expect(page).to_not have_content("#{@user.name}")
    end
  end
end
