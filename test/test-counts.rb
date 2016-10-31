require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/counts'
class Test_hashmap < Test::Unit::TestCase
  def test_counts
    a = %w(a b b c c c)
    c = {'a'=>1, 'b'=>2, 'c'=>3}
    assert_equal( c, a.counts )
  end
  def test_counts__block
    a = %w(a b b c c c)
    c = {'A'=>1, 'B'=>2, 'C'=>3}
    assert_equal( c, a.counts{|i|i.upcase} )
  end
  def test_counts_by
    a = %w(a b b c c c)
    c = {'A'=>1, 'B'=>2, 'C'=>3}
    assert_equal( c, a.counts_by{|i|i.upcase} )
  end
  def test_counts_by__noblock
    a = %w(a b b c c c)
    c = {'A'=>1, 'B'=>2, 'C'=>3}
    e = a.counts_by
    assert_equal( c, e.each{|i|i.upcase} )
  end
end

