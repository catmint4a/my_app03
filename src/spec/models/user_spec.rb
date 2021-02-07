require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "is valid with a name, email" do
    user = User.new(
      name: "Aaron",
      email: "tester@example.com",
    )
    expect(user).to be_valid
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
end
