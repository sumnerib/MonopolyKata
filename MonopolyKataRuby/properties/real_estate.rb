############################
#
## author: Isaac Sumner
############################

require_relative "../player.rb"

class Real_Estate < Property 

    def initialize(location, price, rent, name, group)
        super(location, price, rent)
        @name = name
        @group = group
    end

    attr_reader :group

    # add calc rent here

    def to_s
        "#{@number}: #{@name}(#{@group})"    
    end
end