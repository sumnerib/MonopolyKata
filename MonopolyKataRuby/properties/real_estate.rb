############################
#
## author: Isaac Sumner
############################

require_relative "../player.rb"

class Real_Estate < Property 

    def initialize(location, price, rent, name, group)
        super(location, price, rent, name)
        @group = group
    end

    attr_reader :group

    # add calc rent here
    def calc_rent(all_owned)
        @rent = all_owned ? @rent * 2 : @rent
    end

    def to_s
        "#{@number}: #{@name}(#{@group})"    
    end
end