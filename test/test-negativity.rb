require 'test/unit'
$VERBOSE = true

require 'bigdecimal'

$neg = [ -1, -(2**65), -3.14, Rational(-1,2), BigDecimal.new('-1') ]
$pos = [ +1, +(2**65), +3.14, Rational(+1,2), BigDecimal.new('+1') ]
$zer = [  0, 0.0, BigDecimal.new('0') ]
$err = [ Complex(1,1) ]

require_relative '../lib/mug/negativity'
class Test_negativity < Test::Unit::TestCase

	alias :assert_true :assert
	def assert_false val, msg=UNASSIGNED
		assert !val, msg
	end

	def test_negative
		$neg.each {|n| assert_true  n.negative?, "#{n} should be negative" }
		$pos.each {|n| assert_false n.negative?, "#{n} should not be negative" }
		$zer.each {|n| assert_false n.negative?, "#{n} should not be negative" }
		$err.each do |n|
			assert_raise(NoMethodError) { n.negative? }
		end
	end

	def test_positive
		$neg.each {|n| assert_false n.positive?, "#{n} should not be positive" }
		$pos.each {|n| assert_true  n.positive?, "#{n} should be positive" }
		$zer.each {|n| assert_false n.positive?, "#{n} should not be positive" }
		$err.each do |n|
			assert_raise(NoMethodError) { n.positive? }
		end
	end

	def test_nonnegative
		$neg.each {|n| assert_false n.nonnegative?, "#{n} should not be nonnegative" }
		$pos.each {|n| assert_true  n.nonnegative?, "#{n} should be nonnegative" }
		$zer.each {|n| assert_true  n.nonnegative?, "#{n} should be nonnegative" }
		$err.each do |n|
			assert_raise(NoMethodError) { n.nonnegative? }
		end
	end

	def test_nonpositive
		$neg.each {|n| assert_true  n.nonpositive?, "#{n} should be nonpositive" }
		$pos.each {|n| assert_false n.nonpositive?, "#{n} should not be nonpositive" }
		$zer.each {|n| assert_true  n.nonpositive?, "#{n} should be nonpositive" }
		$err.each do |n|
			assert_raise(NoMethodError) { n.nonpositive? }
		end
	end

end

