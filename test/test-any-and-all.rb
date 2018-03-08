require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/enumerable/any-and-all'
class Test_any_and_all < Test::Unit::TestCase
  def test_any_and_all__block
    b = proc {|o| o > 1 }
    [
      [ false, [] ],
      [ false, [3,0,9] ],
      [ true,  [3,5,9] ],
    ].each do |x, a|
      assert_equal( x, a.any_and_all?(&b) )
    end
  end
  def test_any_and_all__noblock
    [
      [ false, [] ],
      [ false, [3,nil,9] ],
      [ true,  [3,5,9] ],
    ].each do |x, a|
      assert_equal( x, a.any_and_all? )
    end
  end
end
