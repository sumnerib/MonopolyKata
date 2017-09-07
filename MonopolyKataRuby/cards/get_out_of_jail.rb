############################
#
## author: Isaac Sumner
############################

require_relative "card.rb"

class Get_Out_of_Jail < Card
    
    def initialize(description)
        @description = description
    end

    attr_reader :description

    def perform(player)
        player.get_out_of_jail = self
    end
end