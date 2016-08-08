require 'open-uri'

class Import
  ROOT_URL = "http://www.languagedaily.com/learn-german/vocabulary/common-german-words"
  ROOT_URL_2 = "http://www.languagedaily.com/learn-german/vocabulary/most-common-german-words-2"

  def self.run
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
    create_users
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
        user_id: 1
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
end
