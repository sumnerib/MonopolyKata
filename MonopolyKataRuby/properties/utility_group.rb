############################
#
## author: Isaac Sumner
############################

require_relative "../player.rb"
require_relative "../properties/property_consts.rb"
require_relative "property_group.rb"

class Utility_Group < Property_Group 

    def initialize()
        @properties = [] 
    end

    attr_reader :properties

    # Tells the properties to update their rent
    def update_rent(roll)
        num_owned = 0
        @properties.each { |u| num_owned += 1 if u.owned }
        @properties.each { |u| u.calc_rent(roll, (num_owned > 1))}
    end
end