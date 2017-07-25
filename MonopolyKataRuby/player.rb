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

    # Move out ****
    def roll(dice)
        dice.roll()
    end

    def add_balance(money)
        @balance += money
    end

    def subtract_balance(money)
        @balance = @balance > money ? @balance - money : 0
    end
end
