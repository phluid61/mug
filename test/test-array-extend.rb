require 'test/unit'
$VERBOSE = true

if RUBY_VERSION.to_f < 1.9
	class Symbol
		def next
			to_s.next.to_sym
		end
	end
end

require_relative '../lib/mug/array/extend'
class Test_array_extend < Test::Unit::TestCase

	def test_array_extend_err
		a = []
		assert_raise(ArgumentError) { a.extend }
		assert_raise(ArgumentError) { a.extend(1,2,3) }
		assert_raise(ArgumentError) { a.extend(-1) }
	end
	def test_array_extend_1
		a = [1,2]
		assert_equal( [1,2,nil],     a.extend(1) )
		assert_equal( [1,2,nil,nil], a.extend(2) )
		assert_equal( [1,2,3],       a.extend(1,3) )
		assert_equal( [1,2,3,3],     a.extend(2,3) )
	end
	def test_array_extend_2
		a = [1,2]
		b = [9,8]
		assert_equal( [1,2,1,2], a.extend(a) )
		assert_equal( [1,2,9,8], a.extend(b) )
	end
	def test_array_extend_3
		a = ['a','b']
		assert_equal( ['a','b',2,3,4], a.extend(3){|i| i } )
		assert_equal( ['a','b'], a )
	end

	def test_array_extendbang_err
		a = []
		assert_raise(ArgumentError) { a.extend! }
		assert_raise(ArgumentError) { a.extend!(1,2,3) }
		assert_raise(ArgumentError) { a.extend!(-1) }
	end
	def test_array_extendbang_1
		a = [1,2]
		assert_equal( [1,2,nil],         a.extend!(1) )
		assert_equal( [1,2,nil,nil,nil], a.extend!(2) )
		a = [1,2]
		assert_equal( [1,2,3],     a.extend!(1,3) )
		assert_equal( [1,2,3,3,3], a.extend!(2,3) )
	end
	def test_array_extendbang_2
		a = [1,2]
		b = [9,8]
		assert_equal( [1,2,1,2],     a.extend!(a) )
		assert_equal( [1,2,1,2,9,8], a.extend!(b) )
	end
	def test_array_extendbang_3
		a = ['a','b']
		assert_equal( ['a','b',2,3,4], a.extend!(3){|i| i } )
		assert_equal( ['a','b',2,3,4], a )
	end
end


