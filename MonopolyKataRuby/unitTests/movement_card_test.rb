##
#
#
## author: Isaac Sumner
############################

require_relative "../cards/movement_card.rb"
require_relative "../player.rb"
require_relative "../board.rb"
require "test/unit"

class Movement_Card_Test<Test::Unit::TestCase

    def test_movement_card 

        b = Board.new()
        mcSpace = Movement_Card.new("Advance to Go (Collect $200)", 0, b)
        mcForward = Movement_Card.new("Advance to Illinois Ave.", 24, b)
        mcBackward = Movement_Card.new("Go back 3 spaces", -3, b)
        mcRailroad = Movement_Card.new("Advance token to the nearest Railroad and pay owner twice the rental to which he/she is otherwise entitled. If Railroad is unowned, you may buy it from the Bank. (There are two of these.)", "nextRR", b)
        mcUtil = Movement_Card.new("Advance token to nearest Utility. If unowned, you may buy it from the Bank. If owned, throw dice and pay owner a total ten times the amount thrown.", "nextUtil", b)

        player = Player.new("Hat")

        mcSpace.perform_movement(player)
        assert_equal(200, player.balance)
        assert_equal(0, b.get_location(player))

        mcForward.perform_movement(player)
        assert_equal(24, b.get_location(player))

        mcBackward.perform_movement(player)
        assert_equal(21, b.get_location(player))

        mcRailroad.perform_movement(player)
        assert_equal(25, b.get_location(player))

        mcUtil.perform_movement(player)
        assert_equal(28, b.get_location(player))
    end
end