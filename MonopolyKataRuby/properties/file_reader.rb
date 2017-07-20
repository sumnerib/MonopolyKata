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

        def next 
            raise "Out of File Data" if !@has_next
            @lines[@index]
            @index += 1
        end
    end

end