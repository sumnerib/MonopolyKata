############################
#
## author: Isaac Sumner
############################

require_relative "card.rb"

class Movement_Card < Card 

    def initialize(description, whereTo, board)
        super(description)
        @whereTo = whereTo
        @board = board
        @NEXT_RR = "nextRR"
        @NEXT_UTIL = "nextUtil"
        @GO_TO_JAIL = "goToJail"
    end

    def perform(player)
        perform_movement(player)
    end

    def perform_movement(player)
        puts description
        loc = @board.get_location(player)
        case @whereTo
        when @NEXT_RR
            @whereTo = next_railroad(loc) 
        when @NEXT_UTIL
            @whereTo = next_utility(loc)
        when @GO_TO_JAIL
            @board.send_to_jail(player)
            return
        end

        roll = 0
        if @whereTo < 0
            roll = @whereTo
        else
            if (loc < @whereTo)
                roll = (40 + @whereTo) - loc
            else
                roll = @whereTo - loc
            end
        end

        player.move(@board, roll)         
    end

    def next_railroad(location)
        if (location >= 35) || (location < 5)
            return 5
        elsif location.between?(5, 14)
            return 15
        elsif location.between?(15, 24)
            return 25
        else
            return 35
        end
    end

    def next_utility(location)
        if (location >= 28) || (location < 12)
            return 12
        else
            return 28
        end
    end
end
