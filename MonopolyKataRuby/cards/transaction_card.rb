############################
#
## author: Isaac Sumner
############################

require_relative "card.rb"

class Transaction_Card < Card 

    def initialize(description, amount, is_collect)
        super(description)
        @amount = amount
        @is_collect = is_collect
    end

    # TODO: do the transaction
    def perform_transaction(player)
    end
end