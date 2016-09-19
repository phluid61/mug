require 'test/unit'
$VERBOSE = true

$coercable = Object.new
def $coercable.to_h
  {:a=>0, :z=>99}
end

require_relative '../lib/mug/hash/merge'
class Test_hashop < Test::Unit::TestCase
  def test_hash_merge_left
    l = { :a => 1, :b => 1,          :d => nil, :e => 1 }
    r = { :a => 2,          :c => 2, :d => 2,   :e => nil}
    x = { :a => 1, :b => 1, :c => 2, :d => 2,   :e => 1 }
    assert_equal( x, l.merge_left(r) )
  end
  def test_hash_merge_right
    l = { :a => 1, :b => 1,          :d => nil, :e => 1 }
    r = { :a => 2,          :c => 2, :d => 2,   :e => nil}
    x = { :a => 2, :b => 1, :c => 2, :d => 2,   :e => 1 }
    assert_equal( x, l.merge_right(r) )
  end
  def test_hash_merge_left_bang
    l = { :a => 1, :b => 1,          :d => nil, :e => 1 }
    r = { :a => 2,          :c => 2, :d => 2,   :e => nil}
    x = { :a => 1, :b => 1, :c => 2, :d => 2,   :e => 1 }
    l.merge_left! r
    assert_equal( x, l )
  end
  def test_hash_merge_right_bang
    l = { :a => 1, :b => 1,          :d => nil, :e => 1 }
    r = { :a => 2,          :c => 2, :d => 2,   :e => nil}
    x = { :a => 2, :b => 1, :c => 2, :d => 2,   :e => 1 }
    l.merge_right! r
    assert_equal( x, l )
  end
end


