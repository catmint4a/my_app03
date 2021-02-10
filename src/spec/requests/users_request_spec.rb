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
  describe "GET /users/Aaron" do
    it "returns http success" do
      get "/users/#{@user.name}"
      expect(response).to have_http_status(:success)
    end
    it "is link for current user" do
      visit "/users/#{@user.name}"
      find_link("#{@user.name}")
    end
  end
  describe "GET /users" do
    before do
      visit "/users"
    end
    it "returns http success" do
      get "/users"
      expect(response).to have_http_status(:success)
    end
    it "show first user in page" do
      find_link("#{@user.name}")
    end
    it "show second user in page" do
      find_link("#{@user2.name}")
    end

  end
end
