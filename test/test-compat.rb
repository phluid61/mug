require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/compat'
class Test_compat < Test::Unit::TestCase
  def test_dir_empty
    assert_nothing_raised { Dir.empty? '/' }
  end

  ##########

  def test_comparable_clamp
    [
      [ 12,     0, 100,  12],
      [523,     0, 100, 100],
      [ -3.123, 0, 100,   0],
      ['d', 'a', 'f', 'd'],
      ['z', 'a', 'f', 'f'],
    ].each do |cmp, min, max, exp|
      assert_equal( exp, cmp.clamp(min, max) )
    end
  end

  ##########

  def test_enumerable_sum
    enum = [1,2,3,4].each
    assert_equal( 10, enum.sum )
    assert_equal( 20, enum.sum(10) )
    assert_equal( 20, enum.sum{|v| v * 2 } )
    assert_equal( 30, enum.sum(10){|v| v * 2 } )
  end

  ##########

  def test_enumerable_uniq
    enum = [1,1,2,3,4,5,4,-1].each
    assert_equal( [1,2,3,4,5,-1], enum.uniq )
    assert_equal( [1,2,3,4,5], enum.uniq{|v| v.abs } )
  end

  ##########

  def test_file_empty
    assert_false( File.zero? __FILE__ )
    assert_false( File.empty? __FILE__ )
  end

  ##########

  def test_hash_compact
    hash = {:a=>1, :b=>false, :c=>nil}
    assert_equal( {:a=>1, :b=>false}, hash.compact )
  end

  def test_hash_compact!
    hash = {:a=>1, :b=>false, :c=>nil}
    value = hash.compact!
    assert_same( hash, value )
    assert_equal( {:a=>1, :b=>false}, hash )

    value = hash.compact!
    assert_nil( value )
    assert_equal( {:a=>1, :b=>false}, hash )
  end

  ##########

  def test_hash_transform_values
    hash = {:a=>1,:b=>2,:c=>3}
    assert_equal( {:a=>'1',:b=>'2',:c=>'3'}, hash.transform_values(&:to_s) )
  end

  def test_hash_transform_values!
    hash = {:a=>1,:b=>2,:c=>3}
    hash.transform_values!(&:to_s)
    assert_equal( {:a=>'1',:b=>'2',:c=>'3'}, hash )
  end

  ##########

  def test_string_casecmp?
    a = 'AbC'
    b = 'abc'
    c = 'AbD'

    assert( a.casecmp? a )
    assert( a.casecmp? b )
    assert_false( a.casecmp? c )
    assert_nil( 'foo'.casecmp?(2) )
    assert_nil( "\u{e4 f6 fc}".encode('ISO-8859-1').casecmp?("\u{c4 d6 dc}")  )
  end

  ##########

  def test_yield_self_yeilds_self
    obj = Object.new
    yielded = Object.new # this object is different from the first in every way

    obj.yield_self{|x| yielded = x }
    assert_same( obj, yielded )
  end

  def test_then_yields_self
    obj = Object.new
    yielded = Object.new # this object is different from the first in every way

    obj.then{|x| yielded = x }
    assert_same( obj, yielded )
  end

  def test_yield_self_returns_enum
    obj = Object.new
    yielded = Object.new # this object is different from the first in every way

    enum = obj.yield_self
    assert_instance_of( Enumerator, enum )

    enum.each{|x| yielded = x }
    assert_same( obj, yielded )
  end

  def test_then_returns_enum
    obj = Object.new
    yielded = Object.new # this object is different from the first in every way

    enum = obj.then
    assert_instance_of( Enumerator, enum )
    assert_equal( 1, enum.size )

    enum.each{|x| yielded = x }
    assert_same( obj, yielded )
  end

  def test_yield_self_returns_block_value
    obj = Object.new
    value = obj.yield_self{|_| 123 }
    assert_equal( 123, value )
  end

  ##########
end

