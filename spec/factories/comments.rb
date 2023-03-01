FactoryBot.define do
  sequence :body do |n|
    "#{n} comment body"
  end

  factory :comment do
    body
    post
    user

    trait :invalid do
      body { nil }
    end
  end
end
