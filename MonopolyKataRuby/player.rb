##
#
## author: Isaac Sumner
############################

#require_relative "unitTests/player_test.rb"

class Player

    def initialize(piece)
        @piece = piece
    end

    attr_accessor :piece
    attr_writer   :turn
    attr_accessor :turn
    attr_writer   :location
    attr_accessor :location

    #Redefine equality operator
    def ==(p)
        @piece == p.piece
    end

    def roll(seed)

        r = Random.new(seed)
        r.rand(1..6)
    end
end
