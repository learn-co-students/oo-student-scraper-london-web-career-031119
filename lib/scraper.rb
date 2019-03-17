require 'open-uri'
require 'pry'
require 'nokogiri'
 
# doc = Nokogiri::HTML(open("url"))


class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = doc.css(".student-card")
    
    students.map do |student|
      # binding.pry
      {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    profile = {}
    
    social_media = doc.css(".social-icon-container a")

    # check each social media node
    twitter_node = social_media.find { |node| node.attribute("href").value.include?("twitter") }
    if twitter_node
      profile[:twitter] = twitter_node.attribute("href").value
    end

    linkedin_node = social_media.find { |node| node.attribute("href").value.include?("linkedin") }
    if linkedin_node
      profile[:linkedin] = linkedin_node.attribute("href").value
    end

    github_node = social_media.find { |node| node.attribute("href").value.include?("github") }
    if github_node
      profile[:github] = github_node.attribute("href").value
    end

    blog_node = social_media[3]
    if blog_node
      profile[:blog] = blog_node.attribute("href").value
    end
    
    profile[:profile_quote] = doc.css(".profile-quote").text

    profile[:bio] = doc.css(".description-holder p").text
      
    
    # profile = {
    #   twitter: social_media[0].attribute("href").value,
    #   linkedin: social_media[1].attribute("href").value,
    #   github: social_media[2].attribute("href").value,
    #   blog: social_media[3].attribute("href").value,
    #   profile_quote: doc.css(".profile-quote").text,
    #   bio: doc.css(".description-holder p").text
    # }

    profile

  end

end

# profile_url = "./fixtures/student-site/students/ryan-johnson.html"
# Scraper.scrape_profile_page(profile_url)


# puts "ahahah"

