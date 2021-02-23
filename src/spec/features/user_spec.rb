require 'rails_helper'

RSpec.feature "User", type: :feature do
  describe "with valid information" do
    before do
      visit "/signup"
      fill_in "ユーザー名",       with: "ExampleUser"
      fill_in "メールアドレス",   with: "user@example.com"
      fill_in "パスワード",       with: "foobar001"
      fill_in "パスワードの確認", with: "foobar001"
    end
    it "should create a user" do
      expect { click_button "登録" }.to change(User, :count).by(1)
    end
  end
  describe "link in home with login" do
    before do
      @user = User.new(
        name: "Aaron",
        email: "tester@example.com",
        password: "password",
        password_confirmation: "password",
        )
      @user.save
      sign_in_as(@user)
      visit root_path
    end
    it "users link" do
      expect(page).to have_link 'ユーザー一覧'
    end
    it "acount link" do
      expect(page).to have_link 'アカウント'
    end
    it "profile link" do
      expect(page).to have_link 'プロフィール'
    end
    it "edit link" do
      expect(page).to have_link 'ユーザー情報'
    end
    it "logout link" do
      expect(page).to have_link 'ログアウト'
    end
    it "change user profile successful" do
      visit root_path
      click_link "ユーザー情報"
      fill_in "ユーザー名", with: "AaronSpec"
      fill_in "メールアドレス", with: "AaronSpec@example.com"
      fill_in "パスワード",       with: "password"
      fill_in "パスワードの確認", with: "password"
      click_button "変更を保存する"
      expect(page).to have_content "ユーザー情報を変更しました"
    end
    it "change user profile failed" do
      visit root_path
      click_link "ユーザー情報"
      fill_in "ユーザー名", with: "AaronSpec"
      fill_in "メールアドレス", with: "AaronSpec@example.com"
      fill_in "パスワード",       with: "password"
      fill_in "パスワードの確認", with: "passwords"
      click_button "変更を保存する"
      expect(page).to have_content "情報に誤りがあります"
    end
  end
end