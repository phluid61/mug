require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/iterator'
class IteratorTest < Test::Unit::TestCase
  def test_iterator
    iter = Iterator.new(0, 1) do |o, x|
      o + x
    end
    assert_equal([1,2,3,4,5], iter.take(5))
  end
  def test_iterator2
    # TODO: assert that this calls 'warn'?
    iter = Iterator.new(0, :+, 1)
    assert_equal([1,2,3,4,5], iter.take(5))
  end
end
