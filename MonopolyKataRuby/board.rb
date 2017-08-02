
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
require_relative "properties/file_reader.rb"
require_relative "properties/railroad.rb"
require_relative "properties/real_estate.rb"
require_relative "properties/utility.rb"

class Board

    def initialize()

        @spaces = []
        @jail = Jail.new()
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
        40.times do |i|
            @spaces.push(get_space_instance(i))
        end
    end

    attr_reader :jail

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

    # Moves the player using the dice roll
    def move_player_dice(player, dice)
        if (@jail.in_jail(player))
            new_loc = do_jail(player, dice)
            @spaces[new_loc].add_player(player)
            update_property_groups(new_loc - 10) # Subtract 10 for roll
            return new_loc
        end
        move_player(player, player.roll(dice))
    end

    # Returns the location after movement
    def move_player(player, roll)

        # Leave old location
        cur_loc = get_location(player)
        @spaces[cur_loc].remove_player(player)

        # Calculate next location and move
        times_passing_go = (cur_loc + roll) / 40
        new_loc = (cur_loc + roll) % 40

        # If player lands on go don't overpay
        times_passing_go = new_loc == 0 ? times_passing_go - 1 : times_passing_go 
        
        # Found out if the player needs to be payed for passing go
        times_passing_go.times do
            @spaces[0].pay_player(player)
        end

        new_loc = check_special_move(new_loc)
        if (new_loc == -1)
            @jail.add_player(player)
            return new_loc
        end

        @spaces[new_loc].add_player(player)

        # Tell the property groups to update their rent rates if necessary
        update_property_groups(roll)

        return new_loc
    end

    def get_space_instance(location)
        case location
            when 0 then Go_Space.new()
            when 4 then Income_Tax.new()
            when 10 then Just_Visiting.new()
            when 30 then Go_To_Jail.new(@jail)
            when 38 then Luxury_Tax.new()
            when 2, 7, 17, 20, 22, 33, 36 then Space.new(location)
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
                when 2 then new_loc = 10
                else new_loc = @jail.pay_to_leave(player, dice) + 10
            end
        else
            new_loc = @jail.pay_to_leave(player, dice) + 10
        end

        return new_loc 
    end

    # Tells the property groups to update their rates if necessary
    def update_property_groups(roll)
        @property_groups.each { |_, v| v.update_rent(roll) }
    end
end
