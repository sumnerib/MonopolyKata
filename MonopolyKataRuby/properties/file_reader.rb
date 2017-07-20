############################
#
## author: Isaac Sumner
############################

class File_Reader

    def initialize(input_file)

        @lines = []
        File.open(input_file).readlines.each do |line|
            @lines.push(line.split(","))
            @has_next = true
            @index = 0    
        end
    end
    
    attr_reader :has_next

    # Gets the next array line data
    def next 
        raise "Out of File Data" if !@has_next
        next_line = @lines[@index]
        @index += 1
        return next_line
    end
end