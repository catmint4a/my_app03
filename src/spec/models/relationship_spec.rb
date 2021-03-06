require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe "validation" do
    let(:user){ FactoryBot.create(:users) }
    let(:other_user){ FactoryBot.create(:users) }
    let(:relationship){ user.active_relationships.build(followed_id: other_user.id) }

    it "is valid with test data" do
      expect(relationship).to be_valid
    end

    describe "presence" do
      it "is invalid without follower_id" do
        relationship.follower_id = nil
        expect(relationship).to be_invalid
      end
      it "is invalid wihtout followed_id" do
        relationship.followed_id = nil
        expect(relationship).to be_invalid
      end
    end
  end
end
