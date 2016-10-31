require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/loop-with'
class Test_loop_with < Test::Unit::TestCase

  def test_loop_with_index__block
    a = []
    b = []
    x = loop_with_index do |i|
      a << i
      break if a.length >= 3
    end
    y = loop_with_index do |i|
      b << i
      throw StopIteration if b.length >= 3
    end
    assert_equal( [0,1,2], a )
    assert_equal( [0,1,2], b )
    assert_equal( 2, x )
    assert_equal( 2, y )
  end
  def test_loop_with_index__block_offset
    a = []
    b = []
    x = loop_with_index(10) do |i|
      a << i
      break if a.length >= 3
    end
    y = loop_with_index(10) do |i|
      b << i
      throw StopIteration if b.length >= 3
    end
    assert_equal( [10,11,12], a )
    assert_equal( [10,11,12], b )
    assert_equal( 12, x )
    assert_equal( 12, y )
  end
  def test_loop_with_index__enum
    a = []
    b = []
    enum = loop_with_index
    x = enum.each do |i|
      a << i
      break if a.length >= 3
    end
    y = enum.each do |i|
      b << i
      throw StopIteration if b.length >= 3
    end
    assert_equal( [0,1,2], a )
    assert_equal( [0,1,2], b )
    assert_equal( 2, x )
    assert_equal( 2, y )
  end
  def test_loop_with_index__enum_offset
    a = []
    b = []
    enum = loop_with_index(10)
    x = enum.each do |i|
      a << i
      break if a.length >= 3
    end
    y = enum.each do |i|
      b << i
      throw StopIteration if b.length >= 3
    end
    assert_equal( [10,11,12], a )
    assert_equal( [10,11,12], b )
    assert_equal( 12, x )
    assert_equal( 12, y )
  end

end

