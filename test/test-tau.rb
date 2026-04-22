require 'test/unit'
require 'bigdecimal'
require 'bigdecimal/math'

$VERBOSE = true
require_relative '../lib/mug/tau'
class Test_tau < Test::Unit::TestCase
  def test_math_tau
    # 6.283185307179586..
    assert_equal(Math::TAU, Math::PI*2.0)
  end

  include BigMath
  def test_TAU
    assert_equal(TAU(3).round(1).to_s('F'), '6.3')
    assert_equal(TAU(50).truncate(50).to_s('F'), '6.28318530717958647692528676655900576839433879875021')
    assert_raise(ArgumentError) { TAU(0) }
    assert_raise(ArgumentError) { TAU(-3) }
    assert_raise(ArgumentError) { TAU('barf') }
  end
end

