FactoryBot.define do
  sequence :email do |n|
    "#{n}_user@test.com"
  end

  factory :user do
    email
    password { '111111' }
    password_confirmation { '111111' }
    confirmed_at { DateTime.now }
  end
end
