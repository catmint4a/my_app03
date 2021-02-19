module LoginSupport
  def sign_in_as(user)
    visit root_path
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
  end
  def sign_in_as_rememberme(user)
    visit root_path
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    check "ログイン情報を記憶する"
    click_button "ログイン"
  end
  def log_in_as(user, remember_me: '1')
    post login_path, params: { session: {
      email: user.email,
      password: user.password,
      remember_me: remember_me,
    } }
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
