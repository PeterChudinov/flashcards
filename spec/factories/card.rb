FactoryGirl.define do
  factory :card do
    original_text " ПРИВЕТ"
    translated_text "hi "
  end

  factory :deck do
    name 'animals'

    factory :deck_with_cards do
      transient do
        card_count 2
      end

      after(:create) do |deck, evaluator, user|
        create_list(:card, evaluator.card_count, deck: deck)
      end
    end
  end
end
