require 'test/unit'
$VERBOSE = true

if RUBY_VERSION.to_f < 1.9
	class Symbol
		def next
			to_s.next.to_sym
		end
	end
end

require_relative '../lib/mug/hashmap'
class Test_hashmap < Test::Unit::TestCase
	def test_hashmap
		h        = {'s'=>1, :x=>2, 3=>'a'}
		h_k_next = {'t'=>1, :y=>2, 4=>'a'}
		h_v_next = {'s'=>2, :x=>3, 3=>'b'}
		h_p_next = {'t'=>2, :y=>3, 4=>'b'}
		assert_equal( h_k_next, h.map_keys  {|k| k.next } )
		assert_equal( h_v_next, h.map_values{|v| v.next } )
		assert_equal( h_p_next, h.map_pairs {|k,v| [k.next,v.next] } )
	end
end

