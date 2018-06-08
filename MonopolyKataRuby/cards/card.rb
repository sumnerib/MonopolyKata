############################
#
## author: Isaac Sumner
############################

class Card

    def initialize(description)
        @description = description
    end

    attr_reader :description

    def perform(player)
        raise "Abstract perform has not been implemented"
    end
end