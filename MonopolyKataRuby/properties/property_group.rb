############################
#
## author: Isaac Sumner
############################

require_relative "../player.rb"

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
    def update_rent
        
    end 
end
