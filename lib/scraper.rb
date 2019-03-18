require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    profiles =  doc.css('.student-card')
    profiles.collect do |profile|
      profile_hash = {}
      profile_hash[:name] = profile.css('.student-name').text
      profile_hash[:location] = profile.css('.student-location').text
      profile_hash[:profile_url] = profile.css('a').attribute("href").value
      profile_hash
    end
  end
  
  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    info = {}
    icons = doc.css(".social-icon-container a")
    icons.each do |icon|
      check = icon.attribute("href").value
      case 
      when check.include?("twitter")
        info[:twitter] = check
      when check.include?("linkedin")
        info[:linkedin] = check
      when check.include?("github")
        info[:github] = check
      else
        info[:blog] = check
      end
    end
    info[:profile_quote] = doc.css(".profile-quote").text
    info[:bio] = doc.css(".bio-content p").text
    info
  end

end

