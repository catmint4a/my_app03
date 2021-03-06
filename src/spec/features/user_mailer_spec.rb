require 'rails_helper'

RSpec.feature "UserMailers", type: :feature do
  scenario "user send a password reset mail and password reset" do
    @user = FactoryBot.create(:user)
    visit root_path
    click_link "ログイン"
    click_link "(パスワードを忘れた場合はコチラ)"
    fill_in "メールアドレス", with: @user.email
    click_button "再設定用のメールを送信"
    expect(page).to have_content "パスワード再設定用のメールを送信しました"
    @user.create_reset_digest
    visit edit_password_reset_url(@user.reset_token, email: @user.email)
    expect(page).to have_content "パスワードの更新"
    fill_in "パスワード", with: "password"
    fill_in "パスワードの確認", with: "password"
    click_button "パスワードを更新する"
    expect(page).to have_content "パスワードを再設定しました"
    expect(@user.reload.reset_digest).to eq nil
  end

  scenario "user send a password reset mail but wrong email" do
    @user = FactoryBot.create(:user)
    visit root_path
    click_link "ログイン"
    click_link "(パスワードを忘れた場合はコチラ)"
    fill_in "メールアドレス", with: "email@user.email"
    click_button "再設定用のメールを送信"
    expect(page).to_not have_content "パスワード再設定用のメールを送信しました"
    expect(page).to have_content "入力されたメールアドレスを見つけることができませんでした"
  end

  scenario "user send a password reset mail but wrong password" do
    @user = FactoryBot.create(:user)
    visit root_path
    click_link "ログイン"
    click_link "(パスワードを忘れた場合はコチラ)"
    fill_in "メールアドレス", with: @user.email
    click_button "再設定用のメールを送信"
    expect(page).to have_content "パスワード再設定用のメールを送信しました"
    @user.create_reset_digest
    visit edit_password_reset_url(@user.reset_token, email: @user.email)
    expect(page).to have_content "パスワードの更新"
    fill_in "パスワード", with: "password"
    fill_in "パスワードの確認", with: "passwords"
    click_button "パスワードを更新する"
    expect(page).to have_content "パスワードの確認とパスワードの入力が一致しません"
  end

  scenario "user send a password reset mail but expired link" do
    @user = FactoryBot.create(:user)
    visit root_path
    click_link "ログイン"
    click_link "(パスワードを忘れた場合はコチラ)"
    fill_in "メールアドレス", with: @user.email
    click_button "再設定用のメールを送信"
    expect(page).to have_content "パスワード再設定用のメールを送信しました"
    @user.create_reset_digest
    @user.update_attribute(:reset_sent_at, 3.hours.ago)
    visit edit_password_reset_url(@user.reset_token, email: @user.email)
    expect(page).to have_content "パスワードリセットの有効期限は切れました リセット用のメールを再取得してください"
    expect(page).to have_content "パスワードを再設定します"
  end
end
