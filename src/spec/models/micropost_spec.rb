require 'rails_helper'

RSpec.describe Micropost, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  it "is valid micropost" do
    expect(@micropost).to be_valid
  end
  it "is not present user_id" do
    @micropost.user_id = nil
    expect(@micropost).to_not be_valid
  end
  it "is not presetnt content" do
    @micropost.content = "  "
    expect(@micropost).to_not be_valid
  end
  it "is most 140 characters " do
    @micropost.content = "a" * 141
    expect(@micropost).to_not be_valid
  end
  it "is associated microposts should be destroyed" do
    user = User.new(
      name: "Jan",
      user_name: "ジャン",
      email: "jan@example.com",
      password: "password",
      password_confirmation: "password",
      admin: false
      )
    user.save
    micropost = user.microposts.create!(content: "testpost")
    count = Micropost.count
    user.destroy
    expect(Micropost.count).to eq(count - 1)
  end
end
