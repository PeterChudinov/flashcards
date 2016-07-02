require 'open-uri'

loop do |id|
  words_page = Nokogiri::HTML(open("http://languagedaily.com/learn-german/vocabulary/common-german-words-{#{id}"))

  german_words = Array.new()
  english_words = Array.new()

  

  rescue OpenURI::HTTPError => e
    break if e.message == '404 Not Found'
  end
end