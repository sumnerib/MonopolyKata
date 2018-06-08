############################
## Unit Test for Utility 
#
## author: Isaac Sumner
############################

require_relative "../properties/property.rb"
require_relative "../properties/utility.rb"
require_relative "../properties/property_consts.rb"
require "test/unit"

class Utility_test<Test::Unit::TestCase

    def test_utility
        ut = Utility.new(6, 100, "Electric Company")
        assert_equal(4, ut.calc_rent(1, false))
        assert_equal(20, ut.calc_rent(2, true))        
    end
end