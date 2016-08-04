task :tossup => [:environment] do
  @cards = Card.all
  puts "got #{@cards.count} cards"
  @cards.each do |c|
    c.user_id = rand(1..User.all.count)
    c.review_date = rand(1..7).days.ago
    c.save!
    puts "card #{c[:original_text]} is assigned to user #{c[:user_id]}, the review date is now #{c[:review_date]}"
  end
end
