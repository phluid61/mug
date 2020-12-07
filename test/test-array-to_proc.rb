require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/array/to_proc'
class Test_array_to_proc < Test::Unit::TestCase
  def test_to_proc
    a = [:a, :b, :c]
    p = a.to_proc
    assert_equal( p[0], a[0] )
    assert_equal( p[3], a[3] )
    assert_equal( p[-1], a[-1] )
    assert_equal( p[0..-1], a )
    assert_equal( p[0,1], a[0,1] )
    assert_equal( p[1,2], a[1,2] )
    assert_raise(TypeError) { p['not-a-number'] }
  end
end

