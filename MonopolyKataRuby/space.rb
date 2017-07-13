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

    attr_accessor :number
    attr_accessor :players

    def add_player(player)
        @players.push(player)
    end

    def remove_player(name)
        @players.delete(Player.new(name))
    end

    def has_player(name)
        @players.include?(Player.new(name))
    end

    def is_empty
        @players.size == 0
    end
end
