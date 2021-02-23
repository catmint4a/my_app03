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
end
