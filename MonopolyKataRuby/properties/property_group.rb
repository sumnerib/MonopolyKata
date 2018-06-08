############################
#
## author: Isaac Sumner
############################

require_relative "../player.rb"
require_relative "../properties/property_consts.rb"

class Property_Group 

    def initialize(group_key)
        @group_key = group_key    
        @properties = [] 
    end

    attr_reader :properties

    # Adds a property to the group
    def add_property(prop)
        @properties.push(prop)
    end
    
    # Tells the properties to update their rent
    def update_rent(roll)
        raise "Unimplemented Method: update_rent(roll)"
    end
end
