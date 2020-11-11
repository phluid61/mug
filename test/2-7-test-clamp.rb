class Test_clamp < Test::Unit::TestCase

  def test_clamp__beginless_range
    rng = (..3)
    assert_raise(RangeError) { 2.clamp(rng) }
  end

  def test_bound__beginless
    rng = (..3)
    assert_raise(RangeError) { rng.bound(2) }

    rng = (...3)
    assert_raise(RangeError) { rng.bound(2) }
  end

end

