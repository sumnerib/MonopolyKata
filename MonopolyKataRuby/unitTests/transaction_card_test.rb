##
#
#
## author: Isaac Sumner
############################

require_relative "../cards/transaction_card.rb"
require_relative "../player.rb"
require "test/unit"

class Transaction_Card_Test<Test::Unit::TestCase

    def test_transaction_card 
        
        tc = Transaction_Card.new("Bank error in your favor – collect $75 ", 
                                  75, false)
        player = Player.new("Dog")

        player.add_balance(100)
        tc.perform_transaction(player)
        assert_equal(175, player.balance)
    end
end