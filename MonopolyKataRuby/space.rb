############################
#
## author: Isaac Sumner
############################

require_relative "player.rb"

class Space

    def initialize(number)
        @number = number
        @players = []
    end

    attr_reader :number
    attr_reader :players

    def add_player(player)
        @players.push(player)
    end

    def remove_player(player)
        @players.delete(player)
    end

    def has_player(player)
        @players.include?(player)
    end

    def is_empty
        @players.size == 0
    end
end
