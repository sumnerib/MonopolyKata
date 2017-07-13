

require_relative "space.rb"
require_relative "player.rb"

class Board

    def initialize()
        @spaces = []
        40.times do |i|
            @spaces.push(Space.new(i))
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

    def get_space(sp)
       @spaces[sp]
    end

    def get_location(player_name)

        get_locations.each { |i|
            return i.number if i.has_player(player_name)
        }
        return 0
    end
end
