############################
## Unit tests for file_reader
#
## author: Isaac Sumner
############################

require_relative "../properties/file_reader.rb"
require_relative "../properties/property.rb"
require "test/unit"

class File_Reader_test<Test::Unit::TestCase

    def test_file_reader
        
        reader = File_Reader.new("C:\\Users\\IBSUMNE\\MonopolyKata\\MonopolyKataRuby\\unitTests\\property_input_test.in")
        assert_equal("Oriental Ave.", reader.next[3])
        assert(reader.has_next)
    end
end