############################
## Unit Test for Property_Group 
#
## author: Isaac Sumner
############################

require_relative "../properties/property.rb"
require_relative "../properties/real_estate.rb"
require_relative "../properties/property_group.rb"
require_relative "../properties/property_consts.rb"
require "test/unit"

class Property_Group_test<Test::Unit::TestCase

    def test_property_group

        pg = Property_Group.new(Property_Consts::DARK_BLUE)
        pp = Real_Estate.new(37, 350, 35, "Park Place", Property_Consts::DARK_BLUE)
        bw = Real_Estate.new(39, 400, 50, "Boardwalk", Property_Consts::DARK_BLUE)
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
    end
end
