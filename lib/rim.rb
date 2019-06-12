class Rim
    attr_accessor rim_size:, width:, height:, optimal_tire:, interface:, valve:, bsd:, erd:, weight:, colors:, spoke:

    @@all = []

    def initialize(rim_hash)
        rim_hash.each {|spec, value| self.send"#{spec}=", value}
        @colors = []
        @spoke = []
        @@all << self
    end

    def self.all
        @@all
    end
