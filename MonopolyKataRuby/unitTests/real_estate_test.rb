############################
## Unit Test for Real_Estate 
#
## author: Isaac Sumner
############################

require_relative "../properties/property.rb"
require_relative "../properties/real_estate.rb"
require_relative "../properties/property_consts.rb"
require "test/unit"

class Real_Estate_test<Test::Unit::TestCase

    def test_real_estate
        re = Real_Estate.new(37, 350, 35, "Park Place", 
                             Property_Consts::DARK_BLUE)
        assert_equal("37: Park Place(Dark-Blue)", re.to_s)
        
        # calc rent
        re.calc_rent(true)
        assert_equal(70, re.rent)
    end
end