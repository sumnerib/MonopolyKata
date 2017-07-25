############################
#
## author: Isaac Sumner
############################

require_relative "property_group.rb"

class Real_Estate_Group < Property_Group 

    def initialize()
        @properties = [] 
    end

    attr_reader :properties

    # Adds a property to the group
    def add_property(prop)
        @properties.push(prop)
    end
    
    def update_rent(roll)
        owner = @properties[0].owner
        all_owned = true
        @properties.each { |re|
            all_owned = re.owned && owner == re.owner
            break if !all_owned
            owner = re.owner
        }
        @properties.each { |re| re.calc_rent(all_owned) }
    end
end
