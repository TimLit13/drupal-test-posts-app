FactoryBot.define do
  sequence :title do |n|
    "#{n} post title"
  end

  factory :post do
    title
    description { "MyString" }
    body { "MyText" }

    trait :invalid do
      title { nil }
    end
  end
end
