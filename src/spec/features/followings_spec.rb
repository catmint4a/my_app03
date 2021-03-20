require 'rails_helper'

RSpec.feature "Followings", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:other_users) { FactoryBot.create_list(:users, 20) }

  before do
    other_users[0..9].each do |other_user|
      user.active_relationships.create!(followed_id: other_user.id)
      user.passive_relationships.create!(follower_id: other_user.id)
    end
    sign_in_as(user)
  end

  scenario "The number of following and followers is correct" do
    click_on "フォロー"
    expect(user.following.count).to eq 10
    user.following.each do |u|
      expect(page).to have_link u.user_name, href: user_path(u)
    end

    click_on "フォロワー"
    expect(user.followers.count).to eq 10
    user.followers.each do |u|
      expect(page).to have_link u.user_name, href: user_path(u)
    end
  end

  scenario "When user clicks on Unfollow, the number of following increases by -1" do
    visit user_path(other_users.second.name)
    expect do
      click_on "フォロー解除"
      expect(page).not_to have_link "フォロー解除"
      # Ajaxの処理待ちの為に入れています
      visit current_path
    end.to change(user.following, :count).by(-1)
  end

  scenario "When user clicks on Follow, the number of following increases by 1" do
    visit user_path(other_users.last.name)
    expect do
      click_on "フォローする"
      expect(page).not_to have_link "フォローする"
      # Ajaxの処理待ちの為に入れています
      visit current_path
    end.to change(user.following, :count).by(1)
  end
end
