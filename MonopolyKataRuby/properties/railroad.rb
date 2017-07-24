############################
#
## author: Isaac Sumner
############################

require_relative "../player.rb"
require_relative "property.rb"

class Railroad < Property 

    def initialize(location, price, name)
        super(location, price, 0, name)
    end

    def calc_rent(num_owned)
        case num_owned
            when 1 then @rent = 25
            when 2 then @rent = 50
            when 3 then @rent = 100
            when 4 then @rent = 200
        end
    end
end