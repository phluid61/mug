require 'test/unit'
$VERBOSE = true

ARRAY = proc { [1,2,3,4,5,6] }
EVEN  = proc { |i| i % 2 == 0 }
E = [2,4,6]
O = [1,3,5]

require_relative '../lib/mug/array/delete_all'
class Test_array_delete_all < Test::Unit::TestCase
  def test_delete_all__block
    a = ARRAY.call
    result = a.delete_all &EVEN
    assert_equal( result, E )
    assert_equal( a, O )
  end
  def test_delete_all__noblock
    a = ARRAY.call
    enum = a.delete_all
    assert( enum.is_a? Enumerator )

    result = enum.each &EVEN
    assert_equal( result, E )
    assert_equal( a, O )
  end
  def test_delete_all__all
    a = E.dup
    result = a.delete_all &EVEN
    assert_equal( result, E )
    assert( a.empty? )
  end
  def test_delete_all__none
    a = O.dup
    result = a.delete_all &EVEN
    assert( result.empty? )
    assert_equal( a, O )
  end
end

