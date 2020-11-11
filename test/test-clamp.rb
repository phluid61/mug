require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/clamp'
class Test_clamp < Test::Unit::TestCase

  def test_clamp
    [
      [2,3],
      [3,3],
      [4,4],
      [5,5],
      [6,5],
    ].each do |num, ex|
      assert_equal( ex, num.clamp(3,5) )
    end
    assert_raise(ArgumentError) { 0.clamp(5,3) }
  end

  def test_clamp__range
    rng = 3..5
    assert_equal( 3, 2.clamp(rng) )
    assert_equal( 4, 4.clamp(rng) )
    assert_equal( 5, 6.clamp(rng) )

    rng = 3...5
    assert_equal( 3, 2.clamp(rng) )
    assert_equal( 4, 4.clamp(rng) )
    assert_raise(ArgumentError) { 6.clamp(rng) }
  end

  def test_bound__inclusive
    rng = 3..5
    assert_equal( 3, rng.bound(2) )
    assert_equal( 3, rng.bound(3) )
    assert_equal( 4, rng.bound(4) )
    assert_equal( 5, rng.bound(5) )
    assert_equal( 5, rng.bound(6) )
  end

  def test_bound__exclusive
    rng = 3...5
    assert_equal( 3, rng.bound(2) )
    assert_equal( 3, rng.bound(3) )
    assert_equal( 4, rng.bound(4) )
    assert_raise(ArgumentError) { rng.bound(5) }
    assert_raise(ArgumentError) { rng.bound(6) }
  end
end

if RUBY_VERSION.to_f >= 2.6
  require_relative '2-6-test-clamp'
end

if RUBY_VERSION.to_f >= 2.7
  require_relative '2-7-test-clamp'
end

