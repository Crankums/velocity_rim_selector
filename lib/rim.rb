class Rim
    attr_accessor rim_size:, width:, height:, optimal_tire:, interface:, valve:, bsd:, erd:, weight:, colors:, spoke:

    @@all = []

    def initialize(rim_hash)
        rim_hash.each {|spec, value| self.send"#{spec}=", value}
        #these two will need to be arrays, or the values saved as arrays when paired to them:
        #colors = []
        #spoke = []
        @@all << self
    end

    def self.all
        @@all
    end
end