require 'open-uri'
hashes = Hash.new

task :populate => [:environment] do

  get_words(Nokogiri::HTML(open("http://www.languagedaily.com/learn-german/vocabulary/common-german-words")))
  get_words(Nokogiri::HTML(open("http://www.languagedaily.com/learn-german/vocabulary/most-common-german-words-2")))
  loop_through_pages

  puts "imported #{hashes.count} hashes (#{Card.count} successful/#{hashes.count} total)"

end

def loop_through_pages
  id = 2

  loop do
    id += 1
    begin
      words_page = Nokogiri::HTML(open("http://languagedaily.com/learn-german/vocabulary/common-german-words-#{id}"))
    rescue OpenURI::HTTPError => e
      if e.message == 'no more pages to parse...'
        break
      end
    end
    get_words(words_page)

  end
end


def get_words(page)
  german_words = Array.new()
  english_words = Array.new()

  page.css("tr[class=rowA]/td[class=bigLetter]").each do |word|
    german_words.push(word.text)
    english_words.push(page.css("tr[class=rowA]/td[3]")[german_words.index(word.text)].text)
  end

  page.css("tr[class=rowB]/td[class=bigLetter]").each do |word|
    german_words.push(word.text)
    english_words.push(page.css("tr[class=rowB]/td[3]")[german_words.index(word.text)].text)
  end

#, tr[class=rowB]/td[class=bigLetter]
  #page.css("tr[class=rowA]/td[class=3], tr[class=rowB]/td[3]").each do |word|
   # english_words.push(word.text)
  #end

  hashes = Array.new
  german_words.each do |w|
    h = Hash.new

    h[:original_text] = w
    h[:translated_text] = english_words[german_words.index(w)]
    hashes.push(h)
    @active_hash = h
    puts h
#===========================================
    @card = Card.create(
      original_text: @active_hash[:original_text],
      translated_text: @active_hash[:translated_text]
    )
    puts @card
#===========================================
  end
end
