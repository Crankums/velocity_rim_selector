require 'open-uri'
require 'pry'

class Scraper

html = open('https://www.velocityusa.com/product/rim')

    def self.application_scraper(html)
        doc = Nokogiri::HTML(html)
        binding.pry
        application = doc.css('#application.content').children.css("#wh-use.wh-applications")
        #i'll likely have to condense the contents of these to an array. How do I capture the descriptor name without the link?
        #then use detector methods to populate an array. bonus: i shouldn't have any hard-coded keys/elements. 
    end
    
    #the product url is found in "#wh-use.wh-applications a". I could throw that directly in the argument, but i feel like there's a better way
    def self.rim_scraper(product_url)
        spec_hash = {}
        #create the container
        #comb the page, then the element
        # iterate the element to populate the hash
        #color and spoke count will both have arrays as values, so once the keys are made, shovel the choices into the waiting containers
    end
end
