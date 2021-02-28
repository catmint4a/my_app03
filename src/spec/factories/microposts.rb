FactoryBot.define do
  factory :micropost do
    content { "MyText" }
    user { "Aaron" }
    association :user
  end

  # factory :micropost_order do
  #   content { "" }
  #   user { "" }
  #   created_at {  }

  factory :microposts, class: Micropost do
    sequence(:content) { |n| "micropost#{n}" }
    # user { |n| "Aaron#{n}" }
    created_at { |n| "#{n}.hours.ago" }
    association :user, factory: :users
  end
end
