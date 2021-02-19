FactoryBot.define do
  factory :user do
    name { "Aaron" }
    email { "tester@example.com" }
    password { "password" }
    remember_digest{""}
  end
end
