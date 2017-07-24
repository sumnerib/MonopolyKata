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
        case @group_key
            when Property_Consts::RAILROAD then railroad_update
            when Property_Consts::UTIL then util_update(roll)
            else real_estate_update
        end
    end
    
    def railroad_update
        @properties.each { |rr| rr.calc_rent(find_num_owned(rr)) }
    end

    def util_update(roll)
        num_owned = 0
        @properties.each { |u| num_owned += 1 if u.owned }
        @properties.each { |u| u.calc_rent(roll, (num_owned > 1))}
    end

    def real_estate_update
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
