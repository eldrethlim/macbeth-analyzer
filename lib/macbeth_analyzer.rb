require 'open-uri'
require 'nokogiri'

class MacbethAnalyzer
  attr_accessor :speeches, :results

  MACBETH_URL = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
  IGNORABLE_SPEAKERS = %w(ALL)

  def initialize
    @document = Nokogiri::HTML(open(MACBETH_URL)) do |config|
      config.strict.noblanks
    end
    @speeches = @document.xpath("//speech")
    @results = Hash.new(0)
  end

  def run
    speeches.each do |speech|
      character_name = speech.css("speaker").text
      next if IGNORABLE_SPEAKERS.include?(character_name)

      line_count = speech.css("line").count
      results[character_name] += line_count
    end

    output_sorted_results
  end

  private

  def output_sorted_results
    results.sort_by { |name, count| count }.reverse.to_h
  end
end
