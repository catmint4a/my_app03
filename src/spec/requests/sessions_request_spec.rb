require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/signup"
      expect(response).to have_http_status(:success)
    end
  end
  describe "user login logout" do
    before do
      @user = User.new(
      name: "Aaron",
      email: "tester@example.com",
      password: "password",
      password_confirmation: "password",
      )
      @user.save
    end
    it "is user login" do      
      visit root_path
      click_link "ログイン"
      fill_in "メールアドレス", with: @user.email
      fill_in "パスワード", with: @user.password
      click_button "ログイン"
      expect(page).to have_content "Aaron"
    end
    it "is user login faild" do      
      visit root_path
      click_link "ログイン"
      fill_in "メールアドレス", with: @user.email
      fill_in "パスワード", with: "12345678"
      click_button "ログイン"
      expect(page).to have_content "メールアドレスまたはパスワードが違います"
    end
    it "is user logout" do      
      visit root_path
      click_link "ログイン"
      fill_in "メールアドレス", with: @user.email
      fill_in "パスワード", with: @user.password
      click_button "ログイン"
      click_link "ログアウト"
      expect(page).to have_content "ゲストログイン"
    end
  end

end
