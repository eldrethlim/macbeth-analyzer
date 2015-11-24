require 'open-uri'
require 'nokogiri'
require 'pry'

doc = Nokogiri::HTML(open("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")) do |config|
  config.strict.noblanks
end

speeches = doc.xpath("//speech")
characters = {}
EXCLUDE_CHARACTER_ELEMENT = 1

speeches.each do |speech|
  character_name = speech.children.first.text
  characters[character_name] = 0 if characters[character_name].nil?
  characters[character_name] += speech.children.count - EXCLUDE_CHARACTER_ELEMENT
end

print characters
