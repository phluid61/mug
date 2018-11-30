require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/iterator/for'
class IterForTest < Test::Unit::TestCase
  def test_iter_for
    # Test on Integer#next => Integer
    assert_equal([1, 2, 3, 4, 5], 0.iter_for(:next).take(5))
    # Test on String#succ => String
    assert_equal(%w[b c d e f g h i j k], 'a'.iter_for(:succ).take(10))
    # Test on Integer#inspect => String#inspect => String
    assert_equal(["1", "\"1\""], 1.iter_for(:inspect).take(2))
  end
  def test_iter_for_args
    # Test with a parameter
    assert_equal([2, 4, 6, 8, 10], 0.iter_for(:+, 2).take(5))
  end
end
