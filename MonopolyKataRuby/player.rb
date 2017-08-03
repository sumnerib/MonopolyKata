##
#
## author: Isaac Sumner
############################

#require_relative "unitTests/player_test.rb"

class Player

    def initialize(piece)
        @piece = piece
        @balance = 0
        @doubles = 0    # Consecutive Doubles
    end

    attr_reader   :piece
    attr_accessor :balance
    attr_accessor :doubles 

    #Redefine equality operator
    def ==(p)
        @piece == p.piece
    end

    def roll(dice)
        val = dice.roll()
        @doubles += 1 if dice.roll1 == dice.roll2
        return val
    end

    def add_balance(money)
        @balance += money
    end

    def subtract_balance(money)
        @balance = @balance > money ? @balance - money : 0
    end
end
