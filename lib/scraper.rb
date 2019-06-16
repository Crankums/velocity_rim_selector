require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

BASE_URL = open('https://www.velocityusa.com/product/rims#application-tab')

    def self.page_scraper
        doc = Nokogiri::HTML(BASE_URL)
        application = doc.css('h3 a').map {|name| name.text}
        links = doc.css('h3 a').map{|link| link['href']}
        app_hash = Hash[application.zip(links)]
        app_hash.each do |name, url|
            Application.new(name, url)
        end    
    end
    
    def self.product_scraper(app_url)
        html = open(app_url)
        doc = Nokogiri::HTML(html)
        rims = doc.css('h3').map {|name| name.text}
        links = doc.css('h3 a').map {|link| link['href']}
        rim_hash = Hash[rims.zip(links)]
        rim_hash.each do |name, url|
             rim = Rim.new(name, url)
             spec_hash = rim_scraper(url)
             rim.add_attributes(spec_hash)
        end
    end

    def self.rim_scraper(rim_url)
        spec_hash = {}
        html = open(rim_url)
        doc = Nokogiri::HTML(html)
        desc = doc.css('#prod_desc').text.strip
        specs = doc.css('#prod_specs p').map {|p| p.text.strip}
        spokes = []
        colors = []
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
            elsif attrib.include?("spoke")
                arr = attrib.split(/[:,]/)
                color = arr.slice(1..arr.length)
                spokes<<arr.first
                colors<<color
            end
            
            spec_hash[:spoke]= spokes.uniq
            spec_hash[:colors]= colors.flatten.uniq
            spec_hash[:desc]= desc
        end
        #binding.pry
        spec_hash
    end  
end
