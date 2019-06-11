require 'open-uri'
require 'pry'

class Scraper

html = open('https://www.velocityusa.com/product/rim')

    def application_scraper(html)
        doc = Nokogiri::HTML(html)
        binding.pry
        app_box = doc.css('#application.content')
        
    end

end
