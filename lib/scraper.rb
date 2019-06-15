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

    def self.rim_scraper(rim_url)
        spec_hash = {}
        html = open(rim_url)
        doc = Nokogiri::HTML(html)
        desc = doc.css('#prod_desc a').map {|p| p.text}
        specs = doc.css('#prod_specs p').map {|p| p.text.strip}
        specs.each do |attrib|
            if attrib.include?("Size")
                spec_hash[:rim_size]= attrib
            elsif attrib.include?("Height")
                spec_hash[:height]= attrib
            elsif attrib.include?("Optimal")
                spec_hash[:optimal_tire]= attrib
            elsif attrib.include?("Interface")
                spec_hash[:interface]= attrib
            elsif attrib.include?("Valve")
                spec_hash[:valve]= attrib
            elsif attrib.include?("BSD")
                spec_hash[:bsd]= attrib
            elsif attrib.include?("ERD")
                spec_hash[:erd]= attrib
            elsif attrib.include?("Weight")
                spec_hash[:weight]= attrib
            end
        end
        spec_hash
    end  
end
