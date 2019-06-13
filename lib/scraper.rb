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
    def self.application_scraper(product_url)
        
        #create the container
        #comb the page, then the element
        # iterate the element to populate the hash
        #color and spoke count will both have arrays as values, so once the keys are made, shovel the choices into the waiting containers
    end
end
