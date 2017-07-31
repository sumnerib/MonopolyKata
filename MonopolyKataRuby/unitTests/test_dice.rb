##
#
## author: Isaac Sumner
############################

require_relative "../dice.rb"

class Test_Dice < Dice

    def initialize(seed=Time.new.usec)
        super()
        @die1 = Random.new(seed)
        @die2 = Random.new(seed)
    end
end