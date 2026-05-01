class Test_clamp < Test::Unit::TestCase

  def test_clamp__beginless_range
    assert_equal( 2, 2.clamp(..3) )
    assert_equal( 3, 5.clamp(..3) )
  end

  def test_bound__beginless
    rng = (..3)
    assert_raise(RangeError) { rng.bound(2) }

    rng = (...3)
    assert_raise(RangeError) { rng.bound(2) }
  end

end

# vim: set ts=2 sts=2 sw=2 expandtab:
