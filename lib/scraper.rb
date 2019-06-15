require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

BASE_URL = open('https://www.velocityusa.com/product/rims#application-tab')

    def self.page_scraper
        doc = Nokogiri::HTML(BASE_URL)
        application = doc.css('h3 a').map {|name| name.text} #in my css selector, I could probably skip the 'a', but it seems prudent to have some kind of range on it
        links = doc.css('h3 a').map{|link| link['href']}
        app_hash = Hash[application.zip(links)]
        app_hash.each do |name, url|
            Application.new(name, url)
        end    
    end
    
    #the product url is found in "#wh-use.wh-applications a". I could throw that directly in the argument, but i feel like there's a better way
    def self.product_scraper(app_url)
        html = open(app_url)
        doc = Nokogiri::HTML(html)
        rims = doc.css('h3').map {|name| name.text}
        links = doc.css('h3 a').map {|link| link['href']}
        rim_hash = Hash[rims.zip(links)]
        rim_hash.each do |name, url|
            Rim.new(name, url)
        end
    end

    def rim_scraper(rim_url)
        html = open(rim_url)
        doc = Nokogiri::HTML(html)
    end

    
end
