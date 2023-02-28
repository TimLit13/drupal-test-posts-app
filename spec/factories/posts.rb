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

    trait :with_images do
      after :create do |post|
        post.images.attach({ io: File.open("#{Rails.root}/README.md"), filename: 'README1.md' })
        post.images.attach({ io: File.open("#{Rails.root}/README.md"), filename: 'README2.md' })
      end
    end
  end
end
