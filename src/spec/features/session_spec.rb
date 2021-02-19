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
end
