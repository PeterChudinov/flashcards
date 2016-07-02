# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'open-uri'

words_page = Nokogiri::HTML(open("http://languagedaily.com/learn-german/vocabulary/common-german-words"))

german_words = Array.new()
english_words = Array.new()

=begin
german_words += words_page.css("tr[class=rowA]/td[class=bigLetter]/text()").to_a
german_words += words_page.css("tr[class=rowB]/td[class=bigLetter]/text()").to_a
#german_words.insert(35, words_page.css("tr[class=rowB]/td[class=bigLetter]/a/text()"))


puts "german_words.count = #{german_words.count}"
puts "german_words is #{german_words[1].class}"
puts german_words.index('Sie')

puts "======"

english_words += words_page.css("tr[class=rowA]/td[3]/text()").to_a
english_words += words_page.css("tr[class=rowB]/td[3]/text()").to_a

puts "english_words.count = #{english_words.count}"

keys = ["original_text", "translated_text"]
h = Hash[keys.map {|x| [x, ""]}]
puts h
=end

words_page.css("tr[class=rowA]/td[class=bigLetter]").each do |word|
  german_words.push(word.text)
end

words_page.css("tr[class=rowB]/td[class=bigLetter]").each do |word|
  german_words.push(word.text)
end

#puts "german_words.count = #{german_words.count}"
#puts "german_word is #{german_words[0].class}"

#puts "======"

words_page.css("tr[class=rowA]/td[3]").each do |translation|
	english_words.push(translation.text)
end

words_page.css("tr[class=rowB]/td[3]").each do |translation|
	english_words.push(translation.text)
end

#puts "english_words.count = #{english_words.count}"
#puts "english_word is #{english_words[0].class}"

#german_words.each do |w|
  #puts "'#{german_words.index(w)}' => '#{w}' => '#{english_words[german_words.index(w)]}'"
#end

#puts "======"

hashes = Array.new
german_words.each do |w|
  h = Hash.new
  h[:original_text] = w
  h[:translated_text] = english_words[german_words.index(w)]
  hashes.push(h)
  #puts "'#{w}' got into hash"
end

#@hash = hashes[0]
#puts @hash[:original_text]


hashes.each do |h|
  @active_hash = h
  puts "attempting to put '#{@active_hash[:original_text]}' into cards..."
  Card.create(
  	original_text: @active_hash[:original_text],
    translated_text: @active_hash[:translated_text]
    )
  puts "'#{@active_hash[:original_text]}' put into Cards"
end

