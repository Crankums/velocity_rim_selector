class Rim
    extend CliProject::Findable
    attr_accessor :url, :desc, :name, :rim_size, :width, :height, :optimal_tire, :interface, :valve, :bsd, :erd, :weight, :spoke, :applications

    @@all = []

    def initialize(name, url, desc = nil, spec_hash = nil)
        @name = name
        @url = url
        @applications = []
        #spec_hash.each {|spec, value| self.send"#{spec}=", value}
        #these two will need to be arrays, or the values saved as arrays when paired to them:
        #colors = []
        #spoke = []
        #application = [] has many, has many
        @@all << self
    end

    # def add_app(app)
    #     app.rims = self unless app.rims == self
    #     @applications << app unless @applications.include?(app)
    # end

    def add_attributes(hash)
        hash.each {|attrib, value| self.send("#{attrib}", value)}
    end

    def self.all
        @@all
    end
end