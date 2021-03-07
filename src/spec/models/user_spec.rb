require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(
    name: "Aaron",
    email: "tester@example.com",
    password: "password",
    password_confirmation: "password",
    admin: false
    )
  end
  it "is valid with a name, email" do    
    expect(@user).to be_valid
  end

  it "is invalid with a no name, no email" do
    user = User.new(
      name: "",
      email: "",
    )
    expect(user).to be_invalid
  end
  it "is invalid with a no name" do
    user = User.new(
      name: "",
      email: "tester@example.com",
    )
    expect(user).to be_invalid
  end
  it "is invalid with a no email" do
    user = User.new(
      name: "Aaron",
      email: "",
    )
    expect(user).to be_invalid
  end
  it "is invalid with a too long name" do
    user = User.new(
      name: "a" * 51,
      email: "tester@example.com",
    )
    expect(user).to be_invalid
  end
  it "is invalid with a too long email" do
    user = User.new(
      name: "Aaron",
      email: "a" * 244 + "@example.com",
    )
    expect(user).to be_invalid
  end
  it "is invalid not unique email " do
    user = User.new(
      name: "Aaron",
      email: "tester@example.com",
    )
    other_user = User.new(
      name: "joe",
      email: "tesTer@example.com",
    )
    other_user.email.downcase!
    user.save
    expect(other_user).to be_invalid
  end
  it "is invalid not unique name " do
    user = User.new(
      name: "Aaron",
      email: "tester@example.com",
    )
    other_user = User.new(
      name: "Aaron",
      email: "teser2@example.com",
    )
    user.save
    expect(other_user).to be_invalid
  end
  it "is invalid email format" do
    user = User.new(
      name: "Aaron",
      email: "tester@example,com",
    )
    expect(user).to be_invalid
  end
  it "is password present, nonblank" do
    @user.password = @user.password_confirmation = " " * 8
    expect(@user).to be_invalid
  end
  it "is password a minimum length" do
    @user.password = @user.password_confirmation = "v" * 7
    expect(@user).to be_invalid
  end

  describe "follow and unfollow" do
    let(:user){ FactoryBot.create(:users) }
    let(:other_user){ FactoryBot.create(:users) }

    before { user.follow(other_user) }

    describe "follow" do
      it "follow success" do
        expect(user.following?(other_user)).to be_truthy
        expect(other_user.followers.include?(user)).to be_truthy
      end
      it "unfollow success" do
        user.unfollow(other_user)
        expect(user.following?(other_user)).to be_falsey
      end
    end
  end

  describe "def feed" do
    let(:user) { FactoryBot.create(:users, :with_microposts) }
    let(:other_user) { FactoryBot.create(:users, :with_microposts) }

    context "when user is following other_user" do

      before { user.active_relationships.create!(followed_id: other_user.id) }

      it "contains other user's microposts within the user's Micropost" do
        other_user.microposts.each do |post_following|
          expect(user.feed.include?(post_following)).to be_truthy
        end
      end

      it "contains the user's own microposts in the user's Micropost" do
        user.microposts.each do |post_self|
          expect(user.feed.include?(post_self)).to be_truthy
        end
      end
    end

    context "when user is not following other_user" do
      it "doesn't contain other user's microposts within the user's Micropost" do
        other_user.microposts.each do |post_unfollowed|
          expect(user.feed.include?(post_unfollowed)).to be_falsy
        end
      end
    end
  end
end
