require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/diggable'
class Test_digabble < Test::Unit::TestCase

  class DiggyClass
    include Diggable

    def initialize *args
      @array = args
    end

    def [] idx
      @array[idx]
    end
  end

  def test_diggable_mid
    z = [99]
    y = DiggyClass.new 0, z
    x = [nil, nil, y]

    path = [2, 1, 0]
    assert_equal( 99, x.dig(*path) )
  end
  def test_diggable_end
    z = [99]
    y = DiggyClass.new 0, z
    x = [nil, nil, y]

    path = [2, 1]
    assert_equal( z, x.dig(*path) )
  end
  def test_diggable_nil
    y = DiggyClass.new 0, nil
    x = [nil, nil, y]

    path = [2, 1, 0]
    assert_equal( nil, x.dig(*path) )
  end
end
