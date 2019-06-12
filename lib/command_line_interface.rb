

class CLI_rim

    def welcome
        puts "Welcome to the wheel builder! Please select an option to begin:"
    end

    def self.list
        Rim.all
    end

end
