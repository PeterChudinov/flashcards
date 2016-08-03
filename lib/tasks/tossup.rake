task :tossup => [:environment] do
  @user1 = User.new
  @user1.email = 'first@last.com'
  @user1.password = '123qwe'
  @user1.password_confirmation = '123qwe'
  @user1.save!

  @user2 = User.new
  @user2.email = 'second@last.com'
  @user2.password = '123qwe'
  @user2.password_confirmation = '123qwe'
  @user2.save!

  @user3 = User.new
  @user3.email = 'third@last.com'
  @user3.password = '123qwe'
  @user3.password_confirmation = '123qwe'
  @user3.save!

  @cards = Card.all
  puts "got #{@cards.count} cards"
  @cards.each do |c|
    c.user_id = rand(1..User.all.count)
    c.review_date = rand(1..7).days.ago
    c.save!
    puts "card #{c[:original_text]} is assigned to user #{c[:user_id]}, the review date is now #{c[:review_date]}"
  end
end
