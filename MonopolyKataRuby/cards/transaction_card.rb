############################
#
## author: Isaac Sumner
############################

require_relative "card.rb"
require_relative "../player.rb"

class Transaction_Card < Card 

    def initialize(description, amount, is_collect)
        super(description)
        @amount = amount
        @is_collect = is_collect
    end

    def perform(player)
        perform_transaction(player)
    end

    def perform_transaction(player)
        puts description
        @is_collect ? player.subtract_balance(@amount) : player.add_balance(@amount)
    end
end