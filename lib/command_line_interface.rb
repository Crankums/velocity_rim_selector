
class CLI

    def run
        self.welcome
        scraper_sequence
    end

    def scraper_sequence
        Scraper.page_scraper
        loop do
            input = main_menu
            if input == "x" || input.include?("ex")
                return
            elsif input.include?("app")          
                puts "Please choose your riding style:\n"
                application_list
                app = app_selector
                if app == nil
                    next
                end
                puts "Please wait while we populate your selection..."
                Scraper.product_scraper(app.url)   
                puts "\nPlease select a rim for more information:"
                rim_list(app)
                rim_input = gets.strip.to_i
                rim = rim_selector(rim_input, app)
                puts "\nWould you like to see the description and specs? (y/n)"
                spec = gets.strip.downcase
                if spec.include?("y")
                    puts "\n"
                    spec_printer(rim)
                end
                puts "\nPlease select your spoke count and color:\n"
                snc = spoke_and_color(rim)
                if confirm_selection?(rim, snc)
                    puts "\nBye!"
                    break
                end
            elsif input.include?("se")
                puts "Please type in the name of the rim you're trying to find:"
                search_input = gets.strip.to_s
                if search(search_input) == nil
                    puts "Sorry, we can't seem to find that rim!"
                end
            end
        end
    end

# Instance methods used in #scraper_sequence

    def welcome
        puts "\nWelcome to the Wheel Builder CLI! Please select an option to begin:"
    end

    def search(input)
        result = Rim.find_by_name(input)
        spec_printer(result)
        puts "#{result.spoke}"
        puts "#{result.colors}"
        puts "Continue with this rim? (y/n)"
        if gets.strip.downcase.include?("y")
            snc = spoke_and_color(result)
            confirm_selection?(result, snc)
        else
            result
        end
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

    def rim_list(app)
         app.rims.each.with_index(1) {|rim, index| puts "#{index}. #{rim.name}"}
    end

    def application_list
        Application.all.map.with_index(1) {|app, index| puts "#{index}. #{app.name}"}
    end

    # I could condense the "_list" methods into one method using a .find_by_name method and an 'or' operator.
    # The idea there is whatever returns a result then gets mapped and listed.

    def app_selector
        input = gets.strip
        int = input.to_i            
        app_arr = Application.all.map {|app| app.name}
        if int <= 0 || int > app_arr.length
            return nil
        end
        result = Application.find_by_name(app_arr[int-1])                
        puts "#{result.name}"        
        result
    end
    # The shortest, laziest solution I have is to move up a couple lines and restart the #run method. This keeps the
    # program from breaking, but does require the user to go back to the list agin. the problem is that because the
    # program is running from inside #app_selector, it becomes the return value for #app_selector.
    # The solution was to name a condition. If #app_selector yielded "nil", the menu would just start over. 
    # #rim_selector would require a similar solution, with an even bigger refactoring. I would have to loop everything
    # south of the line where 'Scraper.product_scraper' appears, which may require breaking the #scraper_sequence method
    # into several methods in order to produce a more manageable code.

    def rim_selector(input, app)
        rim_arr = app.rims.map {|rim| rim.name}
        result = Rim.find_by_name(rim_arr[input - 1])
        #^^change this method to .find_or_create_by_name(rim_arr[input-1])
        #url = result.url
        #spec_hash = result.rim_scraper(url)
        #result.add_attributes(spec_hash)
        puts "#{result.name}"
        result
    end

# I could call on the Scraper.rim_scraper in the #rim_selector method. This would also put the responsibility of
# calling the scraper methods entirely in the CLI class. My only issue was how to make the url available. If I was sure the 
# url to be scraped could be available in the Rim instance, it would simply be a matter of passing a 'rim.url' method into the scraper.

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

    def confirm_selection?(rim, snc)
        puts "You have chosen the #{rim.name} in #{snc[0]},#{snc[1]}."
        puts "\nIs this correct? (y/n)"
        input = gets.strip.downcase
        if input.include?("y")
            puts "\nFantastic choice! Stay tuned for the hub selector extension!"
            return true
        else
            return false
        end
    end
end