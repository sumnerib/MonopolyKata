############################
#
##author: Isaac Sumner
############################

#require_relative "unitTest/game_test.rb"
require_relative "./space.rb"
require_relative "./player.rb"
require_relative "./board.rb"

class Game

    def initialize(rounds, shuffle=false)

        @rounds = rounds
        @board = Board.new()

        # If shuffle is true shuffle chance/chest decks
        if shuffle
            @board.chance.shuffle_deck()
            @board.community_chest.shuffle_deck()
        end

        @players = []
    end

    attr_reader :rounds
    attr_reader :board
    attr_reader :players

    # Returns true if the player was successfully added
    def add_player(name)
        return add_player_instance(Player.new(name))
    end

    def add_player_instance(player)
        if players.size < 8
            @players.push(player)
            return true
        end
        return false
    end

    def create_order(seed=time.usec)

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
            
            i.roll(dice)
            if (doubles_tracker(i))    # Check for 3 consecutive doubles
                new_loc = @board.send_to_jail(i)
            else
                new_loc = i.take_turn(@board, dice)
            end

            scorecard << (new_loc == -1 ? "#{i.piece}: JAIL, " : "#{i.piece}: #{new_loc}, ")
        }
        scorecard[0..(scorecard.size - 3)]
    end

    def dump_board
        
        @board.get_locations.each { |space|
            print "#{space.number}: "
            space.players.each { |player| print "#{player.piece}, " }
            print "\n"
        }

        puts @board.jail.to_s 

        puts "\n**Balances**"
        @players.each { |player| puts "#{player.piece}: #{player.balance}" }
    end

    # Tracks the number of times a player 
    # has rolled consecutive doubles
    # returns true if third time rolling doubles
    def doubles_tracker(player)
        if (player.doubles == 3)
            puts "Here"
            player.doubles = 0
            return true
        else
            return false
        end
    end
end
