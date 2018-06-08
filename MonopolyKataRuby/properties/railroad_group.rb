############################
#
## author: Isaac Sumner
############################

require_relative "../player.rb"
require_relative "property_group.rb"
require_relative "../properties/property_consts.rb"

class Railroad_Group < Property_Group 

    def initialize()
        @properties = [] 
    end

    attr_reader :properties

    # Finds the number owned by the owner of the given property
    def find_num_owned(prop)
        num_owned = 0
        if (prop.owned)
            @properties.each { |p| num_owned += 1 if prop.owner == p.owner }
        end
        return num_owned
    end

    # Tells the properties to update their rent
    def update_rent(roll)
        @properties.each { |rr| rr.calc_rent(find_num_owned(rr)) }
    end
end