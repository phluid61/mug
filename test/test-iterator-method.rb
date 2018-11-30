require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/iterator/method'
class MethodToIterTest < Test::Unit::TestCase
  def test_to_iter
    # Test on Integer#next => Integer
    assert_equal([1, 2, 3, 4, 5], 0.method(:next).to_iter.take(5))
    # Test on String#succ => String
    assert_equal(%w[b c d e f g h i j k], 'a'.method(:succ).to_iter.take(10))
    # Test on Integer#inspect => String#inspect => String
    assert_equal(["1", "\"1\""], 1.method(:inspect).to_iter.take(2))
  end
  def test_iter_for_args
    # Test with a parameter
    assert_equal([2, 4, 6, 8, 10], 0.method(:+).to_iter(2).take(5))
  end
end
