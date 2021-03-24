require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @user1 = FactoryBot.create(:users)
    @user2 = FactoryBot.create(:users)
    @micropost1 = @user1.microposts.create(content: "first post")
    @micropost2 = @user2.microposts.create(content: "first post")

  end
  it "is valid " do
    like = Like.new(user_id: @user1.id, micropost_id: @micropost1.id)
    like.save
    expect(like).to be_valid
  end

  it "is invalid in user nil" do
    like = Like.new(user_id: nil, micropost_id: @micropost1.id)
    expect(like).to_not be_valid
  end

  it "is invalid in micropost nil" do
    like = Like.new(user_id: @user1.id, micropost_id: nil)
    expect(like).to_not be_valid
  end

  it "is invalid in duplicate" do
    like1 = Like.new(user_id: @user1.id, micropost_id: @micropost1.id)
    like2 = Like.new(user_id: @user1.id, micropost_id: @micropost1.id)
    like1.save
    like2.save
    expect(like2).to_not be_valid
  end

  it "is destroyed with delete user" do
    like = Like.new(user_id: @user1.id, micropost_id: @micropost1.id)
    user = @user1
    like.save
    count = Like.count
    user.destroy
    expect(Like.count).to eq(count - 1)
  end
  
  it "is destroyed with delete post" do
    like = Like.new(user_id: @user2.id, micropost_id: @micropost2.id)
    post = @micropost2
    like.save
    count = Like.count
    post.destroy
    expect(Like.count).to eq(count - 1)
  end
end
