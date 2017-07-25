##
#
## author: Isaac Sumner
############################

class Dice

    def initialize()
        @die1 = Random.new()
        @die2 = Random.new()
    end

    def roll
        @die1.rand(1..6) + @die2.rand(1..6)
    end
end