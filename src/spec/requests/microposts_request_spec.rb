require 'rails_helper'

RSpec.describe "Microposts", type: :request do
  let!(:micropost){ FactoryBot.create(:micropost) }
  let(:delete_request){ delete micropost_path(micropost) }
  
  context "when not logged in" do
    it "does not change micropost count" do
      expect { delete_request }.to change(Micropost, :count).by(0)
    end
    it "redirects to login_url" do
      expect(delete_request).to redirect_to(login_url)
    end
  end

  context "login user delete other user's post" do
    let(:user) { FactoryBot.create(:users) }
    # before do
    #   sign_in_as(user)
    # end

    it "does not change micropost count" do
      expect{ delete_request }.to change(Micropost, :count).by(0)
    end
  end

  context "reply to other_user" do
    it "set user_id in reply_to" do
      reply_user = FactoryBot.create(:users)
      to_user = FactoryBot.create(:users)
      micropost = Micropost.new(user_id: reply_user.id,
                                content: "@#{to_user.name} reply_test",
                                in_reply_to: to_user.id)
      micropost.save
      sign_in_as(to_user)
      get root_url
      expect(page).to have_content micropost.content
    end
  end

end
