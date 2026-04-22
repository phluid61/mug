class Test_clamp < Test::Unit::TestCase

  if RUBY_VERSION < '2.7'
    def test_clamp__endless_range
      rng = (1..)
      assert_raise(RangeError) { 2.clamp(rng) }
    end
  else
    def test_clamp__endless_range
      assert_equal( 2, 2.clamp(1..) )
      assert_equal( 1, 0.clamp(1..) )
    end
  end

  def test_bound__endless
    rng = (1..)
    assert_raise(RangeError) { rng.bound(2) }

    rng = (1...)
    assert_raise(RangeError) { rng.bound(2) }
  end

end

