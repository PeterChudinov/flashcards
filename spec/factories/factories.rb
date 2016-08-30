FactoryGirl.define do
  sequence :email do |n|
    "test#{n}@example.com"
  end

  factory :user do
    email { generate :email }
    password "123456"
    password_confirmation "123456"
  end

  factory :deck do
    name 'test deck'
    association :user, factory: :user
  end

  factory :card do
    original_text " ПРИВЕТ"
    translated_text "hi "
    association :deck, factory: :deck
    association :user, factory: :user
  end
end
