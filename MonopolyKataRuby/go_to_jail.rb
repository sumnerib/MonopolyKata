############################
#
## author: Isaac Sumner
############################

require_relative "player.rb"
require_relative "space.rb"

class Go_To_Jail < Space

    def initialize(jail)
        super(30)
        @jail = jail
    end

    def add_player(player)
        @jail.add_player(player)
    end
end