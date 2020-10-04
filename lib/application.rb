class Application
    extend VelocityRimSelector::Findable
    attr_accessor :name, :url, :rims

    @@all = []

    def initialize(name, url = nil)
        @name = name
        @url = url
        @rims = []
        @@all << self
    end

    def self.create(name)
        app = Application.new(name)
        @@all << app
        app
    end

    def add_rims(rim)
        self.rims << rim unless self.rims.include?(rim)
    end


    def self.all
        @@all
    end
end