
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
                puts "\n"
                self.application_list
                app_input = gets.strip.downcase
                app_url = app_selector(app_input)
                Scraper.product_scraper(app_url)
                puts "\n"
                puts "Please select a rim for more information:"
                self.rim_list
                rim_input = gets.strip
                rim = rim_selector(rim_input)
                puts "\n"
                puts "Please select your spoke count and color:"
                puts "\n"
                self.spoke_list(rim)
                
                #binding.pry
            elsif input.include?("se")
                puts "Please type in the name of the rim you're trying to find:"
                rim_input = gets.strip
                rint = rim_input.to_s
                if self.search(rint) == nil
                    puts "Sorry, we can't seem to find that rim!" 

                end
            end
        end
    end

    def welcome
        puts "\n"
        puts "Welcome to the wheel builder! Please select an option to begin:"
    end

    def search(input)
        result = Rim.find_by_name(input)
        spec_printer(result)

    end


    def main_menu
        puts "\n"
        puts "To choose rims by application, please type 'application'"
        puts "\n"
        # puts "To choose rims by name, please type 'name'"
        puts "If you would like to search for a previously viewed rim, please type 'search'"
        puts "\n"
        puts "To exit, type 'x' or 'exit'"
        input = gets.strip.downcase
        input
    end
    
    def spoke_list(rim)
        rim.spoke.each.with_index(1){|count, index| puts "#{index}. #{count}"}
        input = gets.strip
        int = input.to_i
        count = rim.spoke[int-1]
        puts "#{count}"
    end

    def rim_list
         Rim.all.each.with_index(1) {|rim, index| puts "#{index}. #{rim.name}"}
    end

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

    def rim_selector(input)
        int = input.to_i
        rim_arr = Rim.all.map {|rim| rim.name}
        result = Rim.find_by_name(rim_arr[int - 1])
        puts "#{result.name}"
        spec_printer(result)
        result
        #binding.pry
    end

    def spec_printer(rim)
        puts "#{rim.desc}"
        puts "#{rim.height}"
        puts "#{rim.optimal_tire}"
        puts "#{rim.interface}"
        puts "#{rim.valve}"
        puts "#{rim.bsd}"
        puts "#{rim.erd}"
        puts "#{rim.weight}"
    end

    def spoke_selector(input)
        input.to_i        
    end
end