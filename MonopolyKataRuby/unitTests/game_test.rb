##
#
#
## author: Isaac Sumner
############################

require_relative "../board.rb"
require_relative "../space.rb"
require_relative "../player.rb"
require_relative "../game.rb"
require_relative "test_dice.rb"
require "test/unit"

class Game_Test<Test::Unit::TestCase

    def test_game

        td = Test_Dice.new(8, 6)
        g = Game.new(20)
        g.add_player("Horse")
        g.add_player("Car")

        assert_equal(["Horse", "Car"], g.create_order(1))
        assert_equal(["Car", "Horse"], g.create_order(2))

        assert_equal("Car: 7, Horse: 7", g.play_round(td))
        assert_equal("Car: 13, Horse: 14", g.play_round(td))
        assert_equal("Car: 22, Horse: 23", g.play_round(td))

        g2 = Game.new(20)
        g2.add_player("Horse")

        assert_equal("Not enough players", g2.play_round(td))

        # doubles tracker
        td1 = Test_Dice.new(6, 6)
        g.play_round(td1)
        g.play_round(td1)
        assert_equal("Car: JAIL, Horse: JAIL", g.play_round(td1))
        assert(!g.doubles_tracker(g.players[0]))

        # Add player instance
        assert(g.add_player_instance(Player.new("George")))

        # Roll doubles 3 times in a row, never pass or land on go. 
        # Balance is unchanged. Player is in Jail.
        p7 = Player.new("John")
        p7.add_balance(10000)
        g.add_player_instance(p7)
        g.play_round(td1)
        g.play_round(td1)
        g.play_round(td1)
        assert_equal(9850, p7.balance)
        assert(g.board.jail.in_jail(p7))

        # Roll doubles 3 times in a row, pass or land on go during first two 
        # rolls. Balance increases by $200. Player is in Jail.
        p8 = Player.new("Paul")
        p8.add_balance(10000)
        g.add_player_instance(p8)
        td = Test_Dice.new(3, 9)
        g.play_round(td)
        g.play_round(td)
        g.play_round(td)
        g.play_round(td)
        g.play_round(td1)
        assert_equal(9778, p8.balance)
        g.play_round(td1)
        g.play_round(td1)
        assert(g.board.jail.in_jail(p8))

        # Roll doubles 2 times in a row. Player is not in Jail.
        p9 = Player.new("Ringo")
        p9.add_balance(10000)
        g.add_player_instance(p9)
        g.play_round(td1)
        g.play_round(td1)
        assert(!g.board.jail.in_jail(p9))
    end
end
