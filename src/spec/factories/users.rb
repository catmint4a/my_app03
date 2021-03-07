FactoryBot.define do
  factory :user do
    name { "Aaron" }
    email { "tester@example.com" }
    password { "password" }
    remember_digest{""}
    admin { false } 
    end
    
  factory :users, class: User do
    sequence(:name)  { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }
  end

  trait :with_microposts do
    after(:create) { |user| create_list(:micropost, 5, user: user)}
  end
end