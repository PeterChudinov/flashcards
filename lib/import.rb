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
      parse_page(words_page)
    end
  end

  def parse_page(page)
    words = []
    w_id = 0
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

end
