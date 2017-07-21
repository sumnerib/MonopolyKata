############################
#
## author: Isaac Sumner
############################

require_relative "../player.rb"

class Utility < Property 

    def initialize(location, price, name)
        super(location, price, 0)
        @name = name
    end

    def calc_rent(roll, both_owned)
        @rent = both_owned ? roll * 10 : roll * 4
    end
end