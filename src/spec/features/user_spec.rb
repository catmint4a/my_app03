require 'rails_helper'

RSpec.feature "User", type: :feature do
  before do
    @user = User.new(
    name: "Aaron",
    email: "tester@example.com",
    password: "password",
    password_confirmation: "password",
    admin: false
    )
    @user.save

    @user2 = User.new(
    name: "taro",
    email: "taro@example.com",
    password: "password",
    password_confirmation: "password",
    admin: true
    )
    @user2.save
  end

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
      expect(page).to have_content "入力された情報は適切ではありません"
    end
    it "is user name" do
      visit users_path
      find_link("#{@user.name}")
    end
    it "is other user name" do
      visit "/users"
      find_link("#{@user2.name}")
    end
  end
end