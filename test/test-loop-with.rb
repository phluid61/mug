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
      raise StopIteration if b.length >= 3
    end
    assert_equal( [0,1,2], a )
    assert_equal( [0,1,2], b )
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
      raise StopIteration if b.length >= 3
    end
    assert_equal( [10,11,12], a )
    assert_equal( [10,11,12], b )
    assert_equal( 12, y )
  end
  def test_loop_with_index__enum
    enum = loop_with_index
    assert_respond_to( enum, :each )

    a = []
    b = []
    x = enum.each do |i|
      a << i
      break if a.length >= 3
    end
    y = enum.each do |i|
      b << i
      raise StopIteration if b.length >= 3
    end
    assert_equal( [0,1,2], a )
    assert_equal( [0,1,2], b )
    assert_equal( 2, y )
  end
  def test_loop_with_index__enum_offset
    enum = loop_with_index(10)
    assert_respond_to( enum, :each )

    a = []
    b = []
    x = enum.each do |i|
      a << i
      break if a.length >= 3
    end
    y = enum.each do |i|
      b << i
      raise StopIteration if b.length >= 3
    end
    assert_equal( [10,11,12], a )
    assert_equal( [10,11,12], b )
    assert_equal( 12, y )
  end

  def test_loop_with_object__block
    o = "x"
    a = []
    b = []
    x = loop_with_object(o) do |e|
      a << e
      break if a.length >= 3
    end
    y = loop_with_object(o) do |e|
      b << e
      raise StopIteration if b.length >= 3
    end
    assert_equal( [o,o,o], a )
    assert_equal( [o,o,o], b )
    assert( y.equal?(o), "should return `obj`" )
  end
  def test_loop_with_object__enum
    o = "x"
    enum = loop_with_object(o)
    assert_respond_to( enum, :each )

    a = []
    b = []
    x = enum.each do |e|
      a << e
      break if a.length >= 3
    end
    y = enum.each do |e|
      b << e
      raise StopIteration if b.length >= 3
    end
    assert_equal( [o,o,o], a )
    assert_equal( [o,o,o], b )
    assert( y.equal?(o), "should return `obj`" )

    c = []
    loop_with_object(c).with_index do |d, i|
      d << i
      break if i >= 2
    end
    assert_equal( [0,1,2], c )
  end

  def test_loop_with_index__error
    assert_raise(RuntimeError) { loop_with_index {|i| raise 'die' } }
  end
  def test_loop_with_object__error
    a = []
    assert_raise(RuntimeError) { loop_with_object(a) {|e| raise 'die' } }
  end

end

