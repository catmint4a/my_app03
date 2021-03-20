require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  describe "remembering test" do
    before do
      @user = FactoryBot.create(:user) 
    end
    it "login with remembering" do
      sign_in_as_rememberme(@user)
      expect(User.find(@user.id).remember_digest).to_not be_nil
    end
    it "login with not remembering" do
      sign_in_as(@user)
      expect(User.find(@user.id).remember_digest).to be_nil
    end
  end
  describe "user login logout" do
    before do
      @user = User.new(
      name: "Bob",
      user_name: "ボブ",
      email: "Bob@example.com",
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
      expect(page).to have_content "ボブ"
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
    it "can't get users page without login" do
      visit users_path
      expect(page).to have_content "ログインしてください"
    end
    it "can't get user page without login" do
      visit users_path(@user)
      expect(page).to have_content "ログインしてください"
    end
    it "can't get user page without login" do
      visit edit_user_path(@user)
      expect(page).to have_content "ログインしてください"
    end
    it "redirect edit when logged in as other user" do
      @other_user = FactoryBot.create(:user)
      sign_in_as(@user)
      visit edit_user_path(@other_user)
      expect(page).to have_current_path root_url
    end
  end
end
