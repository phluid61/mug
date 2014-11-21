require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/loop-with'
class Test_loop_with < Test::Unit::TestCase

	def test_loop_with_index__block
		arr = []
		x = loop_with_index do |i|
			arr << i
			break if arr.length >= 3
		end
		assert_equal( [0,1,2], arr )
		assert_equal( 2, x )
	end
	def test_loop_with_index__block_offset
		arr = []
		x = loop_with_index(10) do |i|
			arr << i
			break if arr.length >= 3
		end
		assert_equal( [10,11,12], arr )
		assert_equal( 12, x )
	end
	def test_loop_with_index__enum
		arr = []
		enum = loop_with_index
		x = enum.each do |i|
			arr << i
			break if arr.length >= 3
		end
		assert_equal( [0,1,2], arr )
		assert_equal( 2, x )
	end
	def test_loop_with_index__enum_offset
		arr = []
		enum = loop_with_index(10)
		x = enum.each do |i|
			arr << i
			break if arr.length >= 3
		end
		assert_equal( [10,11,12], arr )
		assert_equal( 12, x )
	end

end

