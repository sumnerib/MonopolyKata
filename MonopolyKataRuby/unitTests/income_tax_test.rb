############################
## Unit Test for Income_Tax
#
## author: Isaac Sumner
############################

require_relative "../space.rb"
require_relative "../player.rb"
require_relative "../income_tax.rb"
require "test/unit"

class Income_Tax_test<Test::Unit::TestCase

    def test_income_tax

        p = Player.new("Horse")
        it = Income_Tax.new()

        # Test 1
        p.balance = 1800
        assert_equal(180, it.collect(p))
        assert_equal(1620, p.balance)

        # Test 2
        p.balance = 2200
        assert_equal(200, it.collect(p))
        assert_equal(2000, p.balance)

        # Test 3
        p.balance = 0
        assert_equal(0, it.collect(p))
        assert_equal(0, p.balance)

        # Test 2
        p.balance = 2000
        assert_equal(200, it.collect(p))
        assert_equal(1800, p.balance)

        # Test add_player
        p.balance = 2000
        it.add_player(p)
        assert_equal(1800, p.balance)
    end
end
