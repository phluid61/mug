require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/hash/fetch-assign'
class Test_hashfetchassign < Test::Unit::TestCase
  def test_hashfetchassign
    hsh = {}
    assert_equal( 1, hsh.fetch_assign(:a, 1) )
    assert_equal( {:a => 1}, hsh )
    assert_equal( 1, hsh.fetch_assign(:a, 2) )
    assert_equal( {:a => 1}, hsh )
  end
  def test_hashfetchassign_proc
    hsh = {}
    assert_equal( 1, hsh.fetch_assign(:a) { 1 } )
    assert_equal( {:a => 1}, hsh )
    assert_equal( 1, hsh.fetch_assign(:a) { 2 } )
    assert_equal( {:a => 1}, hsh )
    assert_equal( 'b', hsh.fetch_assign(:b) {|key| key.to_s } )
    assert_equal( {:a => 1, :b => 'b'}, hsh )
  end
end

