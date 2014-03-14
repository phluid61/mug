require 'test/unit'
$VERBOSE = true

$coercable = Object.new
def $coercable.to_h
	{:a=>0, :z=>99}
end

require_relative '../lib/mug/hash/operations'
class Test_hashop < Test::Unit::TestCase
	def test_hash_or
		h = { :a => 1, :b => 2 }
		[
			[{}, h, h],
			[{:c=>3}, h, {:a=>1, :b=>2, :c=>3}],
			[{:a=>0, :b=>0}, h, {:a=>0, :b=>0}],
			[{:a=>0, :c=>3}, h, {:a=>0, :b=>2, :c=>3}],
			[h, {}, h],
		].each do |a, b, x|
			assert_equal( a|b, x )
		end
	end
	def test_hash_plus
		h = { :a => 1, :b => 2 }
		[
			[{}, h, h],
			[{:c=>3}, h, {:a=>1, :b=>2, :c=>3}],
			[{:a=>0, :b=>0}, h, h],
			[{:a=>0, :c=>3}, h, {:a=>1, :b=>2, :c=>3}],
			[h, {}, h],
		].each do |a, b, x|
			assert_equal( a+b, x )
		end
	end
	def test_hash_poke
		h = {}

		# Regular Hash poking
		assert_nothing_raised { h << {:a=>1} }
		assert_equal h, {:a=>1}
		assert_nothing_raised { h << {:b=>2} }
		assert_equal h, {:a=>1,:b=>2}
		assert_nothing_raised { h << {:a=>3} }
		assert_equal h, {:a=>3,:b=>2}
		assert_nothing_raised { h << {:a=>1,:c=>3} }
		assert_equal h, {:a=>1,:b=>2,:c=>3}

		# Two-element Array poking
		assert_nothing_raised { h << [:d,1] }
		assert_equal h, {:a=>1,:b=>2,:c=>3,:d=>1}
		assert_nothing_raised { h << [:d,4] }
		assert_equal h, {:a=>1,:b=>2,:c=>3,:d=>4}

		# Objects with .to_h
		assert_nothing_raised { h << $coercable }
		assert_equal h, {:a=>0,:b=>2,:c=>3,:d=>4,:z=>99}

		# Failure
		assert_raise(ArgumentError) { h << Object.new }
	end
end

