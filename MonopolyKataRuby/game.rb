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

    attr_reader :rounds
    attr_reader :board
    attr_reader :players

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

    def play_round(seed=Time.new.usec)

        # Short-circuit if not enough
        return "Not enough players" if @players.size < 2

        scorecard = ""
        @players.each { |i|

            #Move the player
            new_loc = @board.move_player(i, i.roll(seed))

            scorecard << "#{i.piece}: #{new_loc}, "
        }
        scorecard[0..(scorecard.size - 3)]
    end
end
