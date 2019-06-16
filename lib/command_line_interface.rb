
class CLI

    def run
        self.welcome
        Scraper.page_scraper
        loop do
            input = main_menu
            if input == "x" || input.include?("ex")
                return
            elsif input.include?("app")          
                puts "Please choose your riding style:\n"
                application_list
                app_input = gets.strip.downcase
                app = app_selector(app_input)
                puts "Please wait while we populate your selection..."
                Scraper.product_scraper(app.url) unless Scraper.product_scraper(app.url) != nil 
                puts "\nPlease select a rim for more information:"
                rim_list
                rim_input = gets.strip.to_i
                rim = rim_selector(rim_input)
                puts "\nWould you like to see the description and specs? (y/n)"
                spec = gets.strip.downcase
                if spec.include?("y")
                    puts "\n"
                    spec_printer(rim)
                end
                puts "\nPlease select your spoke count and color:\n"
                snc = spoke_and_color(rim)
                confirm_selection?(app, rim, snc)
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
        puts "\nWelcome to the wheel builder! Please select an option to begin:"
    end

    def search(input)
        result = Rim.find_by_name(input)
        spec_printer(result)
    end


    def main_menu
        puts "\nTo choose rims by application, please type 'application'\n"
        puts "\nIf you would like to search for a previously viewed rim, please type 'search'"
        puts "\nTo exit, type 'x' or 'exit'"
        input = gets.strip.downcase
    end
    
    def spoke_and_color(rim)
        rim.spoke.each.with_index(1){|count, index| puts "#{index}. #{count}"}
        input = gets.strip.to_i
        count = rim.spoke[input-1]
        puts "#{count}"
        puts "\nAnd color?\n"
        rim.colors.each.with_index(1){|color, index| puts "#{index}. #{color}"}
        pick = gets.strip.to_i
        color = rim.colors[pick-1]
        puts "#{rim.colors[pick-1]}"
        result = [count, color]
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
        result
    end

    def rim_selector(input)
        rim_arr = Rim.all.map {|rim| rim.name}
        result = Rim.find_by_name(rim_arr[input - 1])
        puts "#{result.name}"
        #spec_printer(result)
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

    def confirm_selection?(app, rim, snc)
        puts "You have chosen:"
        puts "the #{rim.name}"
        puts "in"
        puts "#{snc}"
        puts "for #{app.name} riding"
        puts "Is this correct? (y/n)"
        input = gets.strip.downcase
        if input.include?("y")
            puts "Fantastic choice! Stay tuned for the hub selector extension!"
            return
        end
    end
end