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
  end

  describe "GET /signup" do
    it "returns http success" do
      get "/signup"
      expect(response).to have_http_status(:success)
    end
  end
  describe "GET /users" do
    it "returns http success" do
      get "/users/#{@user.name}"
      expect(response).to have_http_status(:success)
    end
  end

end
