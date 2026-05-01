class Test_clamp < Test::Unit::TestCase

  def test_clamp__endless_range
    assert_equal( 2, 2.clamp(1..) )
    assert_equal( 1, 0.clamp(1..) )
  end

  def test_bound__endless
    rng = (1..)
    assert_raise(RangeError) { rng.bound(2) }

    rng = (1...)
    assert_raise(RangeError) { rng.bound(2) }
  end

end

# vim: set ts=2 sts=2 sw=2 expandtab:
