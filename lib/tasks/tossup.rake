task :tossup => [:environment] do
  @cards = Card.all
  puts "got #{@cards.count} cards"
  @cards.each do |c|
    c.deck = c.user.decks.sample
    c.save!
  end
end
