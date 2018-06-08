##
#
## author: Isaac Sumner
############################

class Dice

    def initialize()
        @die1 = Random.new()
        @roll1 = -1
        @die2 = Random.new()
        @roll2 = -1
    end

    attr_reader :roll1
    attr_reader :roll2 

    def roll
        @roll1 = @die1.rand(1..6) 
        @roll2 = @die2.rand(1..6)
        @roll1 + @roll2
    end
end