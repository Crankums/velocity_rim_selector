
class CLI

    def run
        self.welcome
        Scraper.page_scraper
        loop do
            input = main_menu
            if input == "x" || input.include?("ex")
                return
            elsif input.include?("app")          
                puts "Please choose your riding style:"
                self.application_list
                app_input = gets.strip.downcase
                url = app_selector(app_input)
                Scraper.product_scraper(url)
                
                return
            # elsif input.include?("nam")
            #     self.rim_list
            elsif input.include?("se")
                rim_input = gets.strip.downcase
                result = self.search(rim_input)
                if self.search(rim_input) == nil
                    puts "Sorry, we can't seem to find that rim!" 
                else result
                end
            end
        end
    end

    def welcome
        puts "Welcome to the wheel builder! Please select an option to begin:"
    end

    def search(input)
        input = gets.strip.downcase
        Rim.find_by_name(input)
    end


    def main_menu
        puts "To choose rims by application, please type 'application'"
        # puts "To choose rims by name, please type 'name'"
        puts "If you know the name of the rim you're looking for, please type 'search'"
        puts "To exit, type 'x' or 'exit'"
        input = gets.strip.downcase
        input
    end



    # def rim_list
    #     Rim.all.each.with_index(1) {|index, name| puts "#{index}. #{Rim.name}"}
    # end

    def application_list
        Application.all.map.with_index(1) {|app, index| puts "#{index}. #{app.name}"}
    end

    def app_selector(input)
        int = input.to_i
        app_arr = Application.all.map {|app| app.name}
        result = Application.find_by_name(app_arr[int-1])
        puts "#{result.name}"
        result.url
    end
end
