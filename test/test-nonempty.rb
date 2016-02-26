require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/nonempty'
require 'thread'
class Test_nonempty < Test::Unit::TestCase
	def test_nonempty
		yes = [
			[nil],
			{ :foo => nil },
			Queue.new.tap{|q| q << 1 },
			'x',
			:x,
		]
		no = [
			[],
			{},
			Queue.new,
			'',
			:'',
		]
		yes.each do |obj|
			assert( obj.nonempty?, "#{obj.inspect} should be nonempty?" )
		end
		no.each do |obj|
			assert( !obj.nonempty?, "#{obj.inspect} should not be nonempty?" )
		end
		assert_raise( NoMethodError ) { Object.new.nonempty? }
	end
end
