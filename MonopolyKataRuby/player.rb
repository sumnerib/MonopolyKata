##
#
## author: Isaac Sumner
############################

#require_relative "unitTests/player_test.rb"

class Player

    def initialize(piece)
        @piece = piece
        @balance = 0
    end

    attr_reader :piece
    attr_accessor :balance

    #Redefine equality operator
    def ==(p)
        @piece == p.piece
    end

    def roll(seed=Time.new.usec)
        r = Random.new(seed)
        r.rand(1..6)
    end

    def add_balance(money)
        @balance += money
    end

    def subtract_balance(money)
        @balance = @balance > money ? @balance - money : 0
    end
end
