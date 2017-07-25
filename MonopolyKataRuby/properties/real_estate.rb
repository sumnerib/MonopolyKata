############################
#
## author: Isaac Sumner
############################

require_relative "../player.rb"

class Real_Estate < Property 

    def initialize(location, price, rent, name, group)
        super(location, price, rent, name)
        @group = group
        @doubled = false
    end

    attr_reader :group

    # add calc rent here
    def calc_rent(all_owned)
        if (all_owned && !@doubled)
            @rent *= 2
            @doubled = true
        end
    end

    def to_s
        "#{@number}: #{@name}(#{@group})"    
    end
end