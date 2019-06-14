
class CLI

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
            elsif input.include?("se")
                puts "Please enter the name of the rim you wish to find:"
                rim_input =gets.strip.downcase
                result = Rim.find_by_name(rim_input) 
                

            end
        end
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



    def rim_list
        Rim.all.each.with_index(1) {|index, name| puts "#{index}. #{Rim.name}"}
    end

    def application_list
        Application.all.each.with_index(1) {|index, name| puts "#{index}. #{Rim.name}"}
    end


end
