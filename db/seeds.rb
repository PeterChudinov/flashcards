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

words_page.css("tr[class=rowA]/td[class=bigLetter]").each do |word|
  german_words.push(word.text)
end

words_page.css("tr[class=rowB]/td[class=bigLetter]").each do |word|
  german_words.push(word.text)
end

words_page.css("tr[class=rowA]/td[3]").each do |word|
	english_words.push(word.text)
end

words_page.css("tr[class=rowB]/td[3]").each do |word|
	english_words.push(word.text)
end

hashes = Array.new
german_words.each do |w|
  h = Hash.new
  h[:original_text] = w
  h[:translated_text] = english_words[german_words.index(w)]
  hashes.push(h)
  @active_hash = h
  Card.create(
  	original_text: @active_hash[:original_text],
    translated_text: @active_hash[:translated_text]
    )
end
