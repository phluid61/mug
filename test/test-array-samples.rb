require 'test/unit'
$VERBOSE = true

$ARRAY = proc { 8.times.to_a }
$TRIES = 40320 # 8 factorial
$MIN = 4
$MAX = 6

class MyPRNG
  def rand n=1.0
    case n
    when Integer
      n - 1
    when Range
      n.max
    when Float
      n.prev_float
    end
  end
end

require_relative '../lib/mug/array/samples'
class Test_array_extend < Test::Unit::TestCase
  def test_samples
    a = $ARRAY.call
    $TRIES.times do
      s = a.samples
      assert( s.length >= 1 )
      assert( s.length <= a.length )
      assert( s.uniq == s )
      assert( s.all? {|n| a.include? n } )
    end
  end
  def test_samples_min
    a = $ARRAY.call
    # successes
    $TRIES.times do
      s = a.samples( :min => $MIN )
      assert( s.length >= $MIN )
      assert( s.length <= a.length )
      assert( s.uniq == s )
      assert( s.all? {|n| a.include? n } )
    end
    # failures
    assert_raise( ArgumentError ) { a.samples( :min => -1 ) }
  end
  def test_samples_max
    a = $ARRAY.call
    # successes
    $TRIES.times do
      s = a.samples( :max => $MAX )
      assert( s.length >= 1 )
      assert( s.length <= $MAX )
      assert( s.uniq == s )
      assert( s.all? {|n| a.include? n } )
    end
    # failures
    assert_raise( ArgumentError ) { a.samples( :max => -1 ) }
  end
  def test_samples_minmax
    a = $ARRAY.call
    # successes
    $TRIES.times do
      s = a.samples( :min => $MIN, :max => $MAX )
      assert( s.length >= $MIN )
      assert( s.length <= $MAX )
      assert( s.uniq == s )
      assert( s.all? {|n| a.include? n } )
    end
    # failures
    assert_raise( ArgumentError ) { a.samples( :min => $MAX, :max => $MIN ) }
  end
  def test_samples_random
    a = $ARRAY.call
    $TRIES.times do
      s = a.samples( :random => Random.new )
      assert( s.length >= 1 )
      assert( s.length <= a.length )
      assert( s.uniq == s )
      assert( s.all? {|n| a.include? n } )
    end
  end
  def test_samples_random2
    a = $ARRAY.call
    $TRIES.times do
      s = a.samples( :random => MyPRNG.new )
      assert( s.length >= 1 )
      assert( s.length <= a.length )
      assert( s.uniq == s )
      assert( s.all? {|n| a.include? n } )
    end
  end
end

