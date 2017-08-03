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
        @players.each { |i| names.push(i.piece) }
        return names
    end

    def play_round(dice)

        # Short-circuit if not enough
        return "Not enough players" if @players.size < 2

        scorecard = ""
        @players.each { |i|
            new_loc = -1
            doubles_tracker(i) ? @board.jail.add_player(i) :  new_loc = @board.move_player_dice(i, dice)
            scorecard << (new_loc == -1 ? "#{i.piece}: JAIL, " : "#{i.piece}: #{new_loc}, ")
        }
        scorecard[0..(scorecard.size - 3)]
    end

    # Tracks the number of times a player 
    # has rolled consecutive doubles
    # returns true if third time rolling doubles
    def doubles_tracker(player)
        if (player.doubles == 3)
            player.doubles = 0
            return true
        else
            return false
        end
    end
end
