require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student = Nokogiri::HTML(File.read(index_url))
  end

  def self.scrape_profile_page(profile_url)

  end

  Scraper.scrape_index_page('fixtures/student-site/index.html')
  binding.pry
  "I've got 99 problems..."

end
