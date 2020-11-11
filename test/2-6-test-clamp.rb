class Test_clamp < Test::Unit::TestCase

  def test_clamp__endless_range
    rng = (1..)
    assert_raise(RangeError) { 2.clamp(rng) }
  end

  def test_bound__endless
    rng = (1..)
    assert_raise(RangeError) { rng.bound(2) }

    rng = (1...)
    assert_raise(RangeError) { rng.bound(2) }
  end

end

