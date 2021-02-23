FactoryBot.define do
  factory :user do
    name { "Aaron" }
    email { "tester@example.com" }
    password { "password" }
    remember_digest{""}
    admin { false } 
    end
end

FactoryBot.define do
  factory :users, class: User do
    sequence(:name)  { |n| "user#{n}"}
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }
  end
end