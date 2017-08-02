############################
#
## author: Isaac Sumner
############################

require_relative "player.rb"

class Jail 

    def initialize
        @players = Hash.new(0)
    end    

    attr_reader :players 

    def add_player(player)
        @players[player] = 0
    end

    def in_jail(player)
        @players.has_key? player 
    end 

    def pay_to_leave(player, dice)
       if player.balance > 50
            @players.delete(player)
            return dice.roll()
       end
       @players[player] += 1
       return -1
    end 

    # Invalid entry returns 1
    def read_in_option
        puts "Enter an option:"
        puts "1:(Roll)"
        puts '2:(Use "Get Out of Jail Free" card)'
        puts "3:(Pay 50$ to leave)"
        opt = gets
        
        case opt.to_i
            when 1..3 then opt.to_i
            else 1
        end
    end

    def roll_to_leave(player, dice)
        dice.roll()
        @players[player] += 1
        if dice.roll1 == dice.roll2
            @players.delete(player)
            return dice.roll1 + dice.roll2 + 10
        end
        return -1
    end

    # Returns the number of turns taken in jail
    def turns_taken(player)
        @players[player]
    end
end
