require 'rails_helper'

RSpec.describe Card, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  card = Card.create(:original_text => ' привет', :translated_text => 'HI ')

  #it "passes a validation to check if texts are not matching" do
    #card.should have(:no).errors_on(:original_text)
  #end

  #it "creates a valid instance" do
    specify { expect(card.original_text).to eq('привет') }
    specify { expect(card.translated_text).to eq('hi') }
  #end

  #it "checks the translation" do
    specify { expect(card.check_answer?(card.translated_text)).to eq(false) }
  #end

  #it "updates the review date after successful review" do
    specify { expect(card.touch_review_date!).to eq(true) }
  #end
end
