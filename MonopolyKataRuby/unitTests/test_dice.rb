##
#
## author: Isaac Sumner
############################

require_relative "../dice.rb"

class Test_Dice < Dice

    def initialize(seed1=Time.new.usec, seed2=Time.new.usec)
        super()
        @die1 = Random.new(seed1)
        @die2 = Random.new(seed2)
    end
end