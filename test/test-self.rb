require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/self'
class Test_self < Test::Unit::TestCase
	def test_self
		obj = Object.new
		assert_equal( 1, 1.self )
		assert_equal( obj, obj.self )
		assert_equal( 6, 2.self{|i| i*3 } )
		assert_equal( {1=>[1,1], 2=>[2,2], 3=>[3]}, [1,1,2,2,3].group_by(&:self) )

		assert_equal( 1, 1.itself )
		assert_equal( obj, obj.itself )
		assert_equal( 6, 2.itself{|i| i*3 } )
		assert_equal( {1=>[1,1], 2=>[2,2], 3=>[3]}, [1,1,2,2,3].group_by(&:itself) )
	end
	def test_revapply
		p = proc {|*args| args }
		assert_equal( [1], 1.revapply(&p) )
		assert_equal( [1,2,3], 1.revapply(2,3,&p) )
		assert_equal( 3, 1.revapply(2,3).size )
	end
end
