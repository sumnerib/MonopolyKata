############################
#
##author: Isaac Sumner
############################

#require_relative "unitTest/game_test.rb"
require_relative "./space.rb"
require_relative "./player.rb"
require_relative "./board.rb"

class Game

    def initialize(rounds)

        @rounds = rounds
        @board = Board.new()
        @players = []
    end

    attr_accessor :rounds
    attr_accessor :board
    attr_accessor :players

    # Returns true if the player was successfully added
    def add_player(name)

        if players.size < 8
            @players.push(Player.new(name))
            return true
        end

        return false
    end

    def create_order(seed)

        @players = @players.shuffle(random: Random.new(seed))

        names = []
        @players.each { |i|
            names.push(i.piece)
        }
        return names
    end

    def play_round(seed)

        # Short-circuit if not enough
        return "Not enough players" if @players.size < 2

        scorecard = ""
        @players.each { |i|

            #Get the spaces
            old_loc = @board.get_location(i)
            new_loc = (i.roll(seed) + old_loc) % 40

            #Move the player
            @board.get_space(new_loc).add_player(i)
            @board.get_space(old_loc).remove_player(i)

            scorecard << i.piece << ": " << "#{new_loc}" << ", "
        }
        return scorecard[0..(scorecard.size - 3)]
    end
end
