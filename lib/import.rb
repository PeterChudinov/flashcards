require 'open-uri'

class Import
  def self.run
    get_words_new(Nokogiri::HTML(open("http://www.languagedaily.com/learn-german/vocabulary/common-german-words")))
    get_words_new(Nokogiri::HTML(open("http://www.languagedaily.com/learn-german/vocabulary/most-common-german-words-2")))
    loop_through_pages
  end
end

def get_words_new(page)
  words = []
  w_id = 0
  page.css('tr.rowA, tr.rowB').each do |j|
    puts words << 
    { original_text: j.css('td[2]').text,
      translated_text: j.css('td[3]').text
    }
    puts @card = Card.create(
      original_text: words[w_id][:original_text],
      translated_text: words[w_id][:translated_text]
    )
    w_id += 1
  end
end

def loop_through_pages
p_id = 2
loop do
  p_id += 1
  begin
    puts "trying page id #{p_id}"
    words_page = Nokogiri::HTML(open("http://languagedaily.com/learn-german/vocabulary/common-german-words-#{p_id}"))
  rescue OpenURI::HTTPError => e
    if e.message == '404 Resourse not found'
      break
    end
  end
  get_words_new(words_page)

  end
end