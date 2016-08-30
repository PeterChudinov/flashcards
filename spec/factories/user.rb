=begin
FactoryGirl.define do
  factory :user do
    email "first.last@example.com"
    password "123456"
    password_confirmation "123456"
    deck
  end
end
=end
