############################
## Unit Test for Property_Group 
#
## author: Isaac Sumner
############################

require_relative "../properties/property.rb"
require_relative "../properties/railroad.rb"
require_relative "../properties/real_estate.rb"
require_relative "../properties/railroad_group.rb"
require_relative "../properties/property_consts.rb"
require "test/unit"

class Railroad_Group_test<Test::Unit::TestCase

    def test_railroad_group

        pg = Railroad_Group.new()
        pp = Railroad.new(5, 200, "Reading Railroad")
        bw = Railroad.new(15, 200, "Pennsylvania")
        pg.add_property(pp)
        pg.add_property(bw)
        assert(pg.properties.include?(pp))
        assert(pg.properties.include?(bw))
        assert(!pg.properties.include?(Real_Estate.new(
            31,
            300,
            26,
            "Pacific Ave.",
            Property_Consts::DARK_GREEN
        )))

        # Update rent
        pg.update_rent(1)
        assert_equal(25, pp.rent)
        assert_equal(25, bw.rent)

        p1 = Player.new("Horse")
        p1.add_balance(1000)
        pp.add_player(p1)
        bw.add_player(p1)

        pg.update_rent(1)
        assert_equal(50, pp.rent)
        assert_equal(50, bw.rent)
    end
end