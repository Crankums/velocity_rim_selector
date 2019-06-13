

class CLI_rim

    def run
        self.welcome
        Scraper.page_scraper
        loop do
            input = main_menu
            if input == "x" || input.include?("ex")
                return
            elsif input.include?("app")
                self.application_list
            elsif input.include?("nam")
                self.rim_list
            elsif name.include?("se")

                
            end

    def welcome
        puts "Welcome to the wheel builder! Please select an option to begin:"
    end

    def main_menu
        puts "To choose rims by application, please type 'application'"
        puts "To choose rims by name, please type 'name'"
        puts "If you know the name of the rim you're looking for, please type 'search'"
        puts "To exit, type 'x' or 'exit'"
        input = gets.strip.downcase
        input
    end

    def self.rim_list
        Rim.all
    end

    def self.application_list
        Application.all
    end


end
