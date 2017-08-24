##
#
## author: Isaac Sumner
############################

#require_relative "unitTests/player_test.rb"

class Player

    def initialize(piece)
        @piece = piece
        @balance = 0
        @doubles = 0    # Consecutive Doubles
        @location = 0
        @dice = nil
    end

    attr_reader   :piece
    attr_reader   :location
    attr_accessor :balance
    attr_accessor :doubles 

    #Redefine equality operator
    #def ==(p)
     #   @piece == p.piece
    #end

    def roll(dice)
        @dice = dice
        val = dice.roll()
        @doubles += 1 if dice.roll1 == dice.roll2
        return val
    end

    # Returns the location after movement
    def move(board, roll)
        
        # Leave old location
        board.spaces[@location].remove_player(self)

        # Calculate next location and move
        times_passing_go = (@location + roll) / 40
        @location = (@location + roll) % 40

        # If player lands on go don't overpay
        times_passing_go = @location == 0 ? times_passing_go - 1 : times_passing_go 
        
        # Found out if the player needs to be payed for passing go
        times_passing_go.times do
            board.spaces[0].pay_player(self)
        end

        if (board.check_special_move(@location) == -1)
            return board.send_to_jail(self)
        end

        board.spaces[@location].add_player(self)

        # Tell the property groups to update their rent rates if necessary
        board.update_property_groups(roll)

        return @location
    end

    # Moves the player using the dice roll
    def take_turn(board, dice)
        if (board.jail.in_jail(self))
            @location = board.do_jail(self, @dice)
            board.spaces[@location].add_player(self) if @location != -1
            board.update_property_groups(@dice.roll1 + @dice.roll2) 
            return @location
        end
        move(board, dice.roll1 + dice.roll2)
    end

    def add_balance(money)
        @balance += money
    end

    def subtract_balance(money)
        @balance = @balance > money ? @balance - money : 0
    end
end
