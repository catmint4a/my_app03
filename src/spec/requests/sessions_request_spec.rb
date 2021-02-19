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
      click_on "ログアウト"
      expect(page).to have_content "ゲストログイン"
    end
  end
  describe 'remember me' do
    before do
      @user = FactoryBot.create(:user)
    end
    it "remembers the cookie when user checks the Remember Me box" do
      log_in_as(@user)
      expect(cookies[:remember_token]).not_to eq nil
    end
    it "does not remembers the cookie when user does not checks the Remember Me box" do
      log_in_as(@user, remember_me: '0')
      expect(cookies[:remember_token]).to eq nil
    end
  end
end
# RSpec.describe "SessionsHelper", type: :helper do
#   let(:user) { FactoryBot.create(:user) }

#   describe 'current_user' do
#     before do
#       remember(user)
#     end

#     it 'current_user returns right when session is nil' do
#       expect(current_user).to eq user
#       expect(is_logged_in?).to be_truthy
#     end
#     it 'current_user returns nil when remember digest is wrong' do
#       user.update_attribute(:remember_digest, User.digest(User.new_token))
#       expect(current_user).to eq nil
#     end
#   end
# end
