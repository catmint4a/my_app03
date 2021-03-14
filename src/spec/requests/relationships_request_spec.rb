require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  # describe "Relationships#create" do
  #   let(:post_request) { post relationships_path }
    
  #   context "when not logged in" do
  #     it "doesn't change Relationship's count" do
  #       expect { post_request }.to change(Relationship, :count).by(0)
  #     end
      
  #     it "redirects to login_url" do
  #       expect(post_request).to redirect_to login_url
  #     end
  #   end
  # end
  
  # describe "Relationships#destroy" do
    
  #   let(:user) { FactoryBot.create(:users) }
  #   let(:other_user) { FactoryBot.create(:users) }
  #   let(:delete_request) { delete relationship_path(other_user) }
  #   before { user.following << other_user }

  #   context "when not logged in" do
  #     it "doesn't change Relationship's count" do
  #       expect { delete_request }.to change(Relationship, :count).by(0)
  #     end

  #     it "redirects to login_url" do
  #       expect(delete_request).to redirect_to login_url
  #     end
  #   end
  # end
end
