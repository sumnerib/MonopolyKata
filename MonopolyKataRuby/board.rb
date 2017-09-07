
require_relative "just_visiting.rb"
require_relative "space.rb"
require_relative "income_tax.rb"
require_relative "go_space.rb"
require_relative "luxury_tax.rb"
require_relative "player.rb"
require_relative "jail.rb"
require_relative "go_to_jail.rb"
require_relative "properties/real_estate_group.rb"
require_relative "properties/utility_group.rb"
require_relative "properties/railroad_group.rb"
require_relative "properties/property_consts.rb"
require_relative "file_reader.rb"
require_relative "properties/railroad.rb"
require_relative "properties/real_estate.rb"
require_relative "properties/utility.rb"
require_relative "cards/card_space.rb"
require_relative "cards/deck.rb"
require_relative "cards/movement_card.rb"
require_relative "cards/transaction_card.rb"
require_relative "cards/get_out_of_jail.rb"

class Board

    def initialize()

        @spaces = []
        @jail = Jail.new()
        
        # Init property groups
        @property_reader = File_Reader.new("C:\\Users\\IBSUMNE\\MonopolyKata\\MonopolyKataRuby\\properties\\property_input.in")
        @property_groups = Hash[
            Property_Consts::PURPLE => Real_Estate_Group.new(),
            Property_Consts::LIGHT_BLUE => Real_Estate_Group.new(),
            Property_Consts::VIOLET => Real_Estate_Group.new(),
            Property_Consts::ORANGE => Real_Estate_Group.new(),
            Property_Consts::RED => Real_Estate_Group.new(),
            Property_Consts::YELLOW => Real_Estate_Group.new(),
            Property_Consts::DARK_GREEN => Real_Estate_Group.new(),
            Property_Consts::DARK_BLUE => Real_Estate_Group.new(),
            Property_Consts::UTIL => Utility_Group.new(),
            Property_Consts::RAILROAD => Railroad_Group.new()
        ]

        # Init cards
        chance_reader = File_Reader.new("C:\\Users\\IBSUMNE\\MonopolyKata\\MonopolyKataRuby\\cards\\chance.in")
        @chance = Deck.new()
        while (chance_reader.has_next)
            line = chance_reader.next()
            case line[0]
            when "Transaction"
                @chance.add_card(Transaction_Card.new(line[3], line[1].to_i,
                                                   line[2] == "true"))
            when "Movement"
                @chance.add_card(Movement_Card.new(line[2], line[1].to_i, self))
            else
                @chance.add_card(Get_Out_of_Jail.new(line[0]))
            end
        end

        community_chest_reader = File_Reader.new("C:\\Users\\IBSUMNE\\MonopolyKata\\MonopolyKataRuby\\cards\\community_chest.in")
        @community_chest = Deck.new()
        while (community_chest_reader.has_next)
            line = community_chest_reader.next()
            case line[0]
            when "Transaction"
                @community_chest.add_card(Transaction_Card.new(line[3], 
                                          line[1].to_i, line[2] == "true"))
            when "Movement"
                @community_chest.add_card(Movement_Card.new(line[2], 
                                                line[1].to_i, self))
            else
                @community_chest.add_card(Get_Out_of_Jail.new(line[0]))
            end
        end

        40.times do |i|
            @spaces.push(get_space_instance(i))
        end
    end

    attr_reader :jail
    attr_reader :spaces
    attr_reader :chance
    attr_reader :community_chest

    # Checks if any special movments need to take place
    def check_special_move(new_loc)

        case new_loc
            when 30 then -1
            else new_loc
        end
    end

    #Gets an array of spaces containing players
    def get_locations

        spaces_with_players = []
        @spaces.each do |space|
            if !space.is_empty
                spaces_with_players.push(space)
            end
        end
        return spaces_with_players
    end

    # Gets the space object givent the location number
    def get_space(sp)
       @spaces[sp]
    end

    # Gets the board location of the given player
    def get_location(player)

        return -1 if @jail.in_jail(player)
        get_locations.each { |i|
            return i.number if i.has_player(player)
        }
        return 0
    end

    # Incarcerates the given player
    def send_to_jail(player)
        @spaces[get_location(player)].remove_player(player)
        @jail.add_player(player)
        return -1
    end

    def get_space_instance(location)
        case location
            when 0 then Go_Space.new()
            when 4 then Income_Tax.new()
            when 10 then Just_Visiting.new()
            when 30 then Go_To_Jail.new(@jail)
            when 38 then Luxury_Tax.new()
            when 2, 17, 33 then Card_Space.new(location, @community_chest)
            when 7, 22, 36 then Card_Space.new(location, @chance)
            when 21 then Space.new(location)
            else get_next_property()
        end
    end

    # Gets next property from file reader while also adding it 
    # to a corresponding property group
    def get_next_property()
        return if !@property_reader.has_next

        line = @property_reader.next
        prop = nil
        case line[4]
            when Property_Consts::RAILROAD
                prop = Railroad.new(line[0].to_i, line[1].to_i, line[3])
            when Property_Consts::UTIL
                prop = Utility.new(line[0].to_i, line[1].to_i, line[3])
            else
                prop = Real_Estate.new(line[0].to_i, line[1].to_i, 
                                       line[2].to_i, line[3], line[4])
        end
        @property_groups[line[4]].add_property(prop)

        return prop 
    end

    def do_jail(player, dice)

        new_loc = -1
        
        # Find out what turn the player is on
        if (@jail.turns_taken(player) < 3)
            # Get the players choice
            case @jail.read_in_option
                when 1 then new_loc = @jail.roll_to_leave(player, dice)
                when 2
                    new_loc = 10 unless player.get_out_of_jail.nil? 
                else new_loc = @jail.pay_to_leave(player, dice)
            end
        else
            new_loc = @jail.pay_to_leave(player, dice)
        end

        return new_loc 
    end

    # Tells the property groups to update their rates if necessary
    def update_property_groups(roll)
        @property_groups.each { |_, v| v.update_rent(roll) }
    end
end
