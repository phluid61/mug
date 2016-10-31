require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/and-or'
class Test_and_or < Test::Unit::TestCase

  def test_and
    assert_equal( 2, 1.and(2) )
    assert_equal( 2, 0.and(2) )
    assert_equal( 2, 'x'.and(2) )
    assert_equal( 2, true.and(2) )
    assert_equal( false, false.and(2) )
    assert_equal( nil,   nil.and(2) )
  end

  def test_and_2
    assert_equal( [1], [1].and([2], &:empty?) )
    assert_equal( [2], [].and([2], &:empty?) )
    assert_equal( 'abc', 'abc'.and(''){|x|x =~ /\d/} )
    assert_equal( '',    'a1c'.and(''){|x|x =~ /\d/} )
  end


  def test_or
    assert_equal( 1,    1.or(2) )
    assert_equal( 0,    0.or(2) )
    assert_equal( 'x',  'x'.or(2) )
    assert_equal( true, true.or(2) )
    assert_equal( 2,    false.or(2) )
    assert_equal( 2,    nil.or(2) )
  end

  def test_or_2
    assert_equal( [2], [1].or([2], &:empty?) )
    assert_equal( [],  [].or([2], &:empty?) )
    assert_equal( '',    'abc'.or(''){|x|x =~ /\d/} )
    assert_equal( 'a1c', 'a1c'.or(''){|x|x =~ /\d/} )
  end

end

