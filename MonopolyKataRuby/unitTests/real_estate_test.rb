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
        re = Real_Estate.new(6, 100, 6, "Oriental Ave.", 
                             Property_Consts::LIGHT_BLUE)
        assert_equal("6: Oriental Ave.(Light-Blue)", re.to_s)        
    end
end