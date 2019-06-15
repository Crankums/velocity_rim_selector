class Application
    extend CliProject::Findable
    attr_accessor :name, :url, :rims

    @@all = []

    def initialize(name, url)
        @name = name
        @url = url
        @rims = []
        @@all << self
    end

    def self.all
        @@all
    end
end