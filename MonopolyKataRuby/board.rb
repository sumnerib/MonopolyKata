
require_relative "just_visiting.rb"
require_relative "space.rb"
require_relative "income_tax.rb"
require_relative "luxury_tax.rb"
require_relative "player.rb"

class Board

    def initialize()

        @spaces = []
        40.times do |i|
            case i
                when 4 then @spaces.push(Income_Tax.new())
                when 10 then @spaces.push(Just_Visiting.new())
                when 38 then @spaces.push(Luxury_Tax.new())
                else @spaces.push(Space.new(i))
            end
        end
    end

    # Checks if any special movments need to take place
    def check_special_move(new_loc)

        case new_loc
            when 30 then 10
            else new_loc
        end
    end

    #Gets an array of spaces containing players
    def get_locations

        spaces_with_players = []
        for space in @spaces
            if !space.is_empty
                spaces_with_players.push(space)
            end
        end
        return spaces_with_players
    end

    # Gets the space object givent the location number
    def get_space(sp)
       @spaces[sp]
    end

    # Gets the board location of the given player
    def get_location(player)

        get_locations.each { |i|
            return i.number if i.has_player(player)
        }
        return 0
    end

    # Returns the location after movement
    def move_player(player, roll)

        cur_loc = get_location(player)
        @spaces[cur_loc].remove_player(player)
        new_loc = check_special_move((cur_loc + roll) % 40)
        @spaces[new_loc].add_player(player)

        return new_loc
    end
end
