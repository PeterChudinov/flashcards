require 'open-uri'

class Import
  ROOT_URL = "http://www.languagedaily.com/learn-german/vocabulary/common-german-words"
  ROOT_URL_2 = "http://www.languagedaily.com/learn-german/vocabulary/most-common-german-words-2"

  def self.run
    new.create_users
    new.create_decks
    new.parse
  end

  def parse
    parse_page(Nokogiri::HTML(open(ROOT_URL)))
    parse_page(Nokogiri::HTML(open(ROOT_URL_2)))
    p_id = 2
    loop do
      p_id += 1
      begin
        puts "trying page id #{p_id}"
        words_page = Nokogiri::HTML(open("http://languagedaily.com/learn-german/vocabulary/common-german-words-#{p_id}"))
      rescue OpenURI::HTTPError => e
        if e.message.eql? '404 Resource not found'
          break
        end
      end
      if parse_page(words_page).nil?
        break
      end
    end
  end

  def parse_page(page)
    words = []
    w_id = 0
    if page.nil?
      return nil
    end
    page.css('tr.rowA, tr.rowB').each do |j|
      puts words << {
        original_text: j.css('td[2]').text,
        translated_text: j.css('td[3]').text
      }
      puts @card = Card.create(
        original_text: words[w_id][:original_text],
        translated_text: words[w_id][:translated_text],
        user_id: 1,
        deck_id: 1
      )
      w_id += 1
    end
  end

  def create_users
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
  end

  def create_decks
    User.all.each do |u|
      3.times do |count|
        u.decks.create(name: "test deck #{count}")
      end
    end
  end

  def tossup
    @cards = Card.all
    puts "got #{@cards.count} cards"
    @cards.each do |c|
      c.user_id = rand(1..User.all.count)
      c.deck_id = c.user.decks.all.sample
      c.review_date = rand(1..7).days.ago
      c.save!
      puts "card #{c[:original_text]} is assigned to user #{c[:user_id]}, the review date is now #{c[:review_date]}"
    end
  end
end
