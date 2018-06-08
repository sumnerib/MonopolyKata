############################
## Unit Test for Railroad 
#
## author: Isaac Sumner
############################

require_relative "../properties/property.rb"
require_relative "../properties/railroad.rb"
require_relative "../properties/property_consts.rb"
require "test/unit"

class Railroad_test<Test::Unit::TestCase

    def test_railroad
        rr = Railroad.new(6, 100, "Reading Railroad")
        assert_equal(25, rr.calc_rent(1))
        assert_equal(200, rr.calc_rent(4))        
    end
end