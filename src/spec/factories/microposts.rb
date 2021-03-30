FactoryBot.define do
  factory :micropost do
    content { "MyText" }
    association :user
  end

  factory :microposts, class: Micropost do
    sequence(:content) { |n| "micropost#{n}" }
    created_at { |n| "#{n}.hours.ago" }
    association :user, factory: :users
  end
end
