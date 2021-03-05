require 'rails_helper'

RSpec.feature "Microposts", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  before do
    @user = FactoryBot.create(:user) 
    @micropost = @user.microposts.create(content: "first post")
    40.times do
      content = Faker::Lorem.sentence(word_count: 4)
      @user.microposts.create!(content: content)
    end
  end


  describe "post test" do
    before do
      sign_in_as @user
      visit root_path
    end
    it "is invalid post" do
      click_on "投稿"
      expect(has_css?('.alert-danger')).to be_truthy
    end
    it "is valid  post" do
      valid_post = "test post"
      fill_in "micropost_content", with: valid_post
      click_on "投稿"
      expect(page).to have_content valid_post
    end
  end
end

