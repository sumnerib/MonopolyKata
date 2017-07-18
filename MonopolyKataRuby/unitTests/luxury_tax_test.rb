############################
## Unit Test for Luxury_Tax
#
## author: Isaac Sumner
############################

require_relative "../space.rb"
require_relative "../player.rb"
require_relative "../luxury_tax.rb"
require "test/unit"

class Luxury_Tax_test<Test::Unit::TestCase

    def test_luxury_tax

        p = Player.new("Horse")
        lt = Luxury_Tax.new()

        # Test 1
        p.balance = 1800
        lt.collect(p)
        assert_equal(1725, p.balance)

        # Test 2
        p.balance = 0
        lt.collect(p)
        assert_equal(0, p.balance)

        # Test add_player
        p.balance = 2000
        lt.add_player(p)
        assert_equal(1925, p.balance)
    end
end
