require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

BASE_URL = open('https://www.velocityusa.com/product/rims#application-tab')

    def self.page_scraper
        doc = Nokogiri::HTML(BASE_URL)
        application = doc.css('h3 a').map {|name| name.text}
        links = doc.css('h3 a').map{|link| link['href']}
        rim_hash = Hash[application.zip(links)]
        
        #i'll likely have to condense the contents of these to an array. How do I capture the descriptor name without the link?
        #then use detector methods to populate an array/hash. bonus: i shouldn't have any hard-coded keys/elements.
        #after that, I can instantiate a Rim with the name I scrape, then populate with a hash grabbed from the next method 
    end
    
    #the product url is found in "#wh-use.wh-applications a". I could throw that directly in the argument, but i feel like there's a better way
    def self.product_scraper(page_url)
        names = []
        sizes = []
        html = open(page_url)
        doc = Nokogiri::HTML(html)
        rims = doc.css('h3').map {|name| name.text.split(" ")}
          #returns an array of arrays
          
        rims.each do |arrs|
            Rim.new(arrs[0], arrs[1]) 
        end
    end
end
