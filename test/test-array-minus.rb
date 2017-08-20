require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/array/minus'
class Test_array_minus < Test::Unit::TestCase

  def test_array_minus
    a = %w[q q w e r e e  ]
    b = %w[q   w e   e   t]
    c = %w[  q     r   e  ]
    d = %w[              t]
    assert_equal( c,     a.minus(b) )
    assert_equal( d,     b.minus(a) )
    assert_equal( c,     a.minus(b, remainder: false) )
    assert_equal( [c,d], a.minus(b, remainder: true ) )
    assert_equal( [d,c], b.minus(a, remainder: true ) )
  end

  def test_array_xor
    [
      [%w[a b c], %w[b c d], %w[a d]],
      [%w[a c b c a], %w[b d c d b], %w[a d]],
    ].each do |a, b, x|
      assert_equal( x, a ^ b )
    end
  end

end

