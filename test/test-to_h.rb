require 'test/unit'

$VERBOSE = true
require_relative '../lib/mug/to_h'
class Test_enum_to_h < Test::Unit::TestCase
	def test_enum_to_h
		assert_equal( {}, [].to_h )
		assert_equal( {1=>nil,2=>nil}, [1,2].to_h )
		assert_equal( {1=>nil,2=>nil}, (1..2).to_h )
		assert_equal( {1=>2,3=>4}, [[1,2],[3,4]].to_h )
		assert_equal( {1=>4}, [[1,2],[1,4]].to_h )
		assert_raise(ArgumentError) { [[1,2,3]].to_h }
	end
end

