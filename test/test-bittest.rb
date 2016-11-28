require 'test/unit'
$VERBOSE = true

$and_any = [
  [0b00,0b00,false],
  [0b00,0b01,false],
  [0b00,0b10,false],
  [0b00,0b11,false],
  [0b01,0b00,false],
  [0b01,0b01,true],
  [0b01,0b10,false],
  [0b01,0b11,true],
  [0b10,0b00,false],
  [0b10,0b01,false],
  [0b10,0b10,true],
  [0b10,0b11,true],
  [0b11,0b00,false],
  [0b11,0b01,true],
  [0b11,0b10,true],
  [0b11,0b11,true],
]
$and_all = [
  [0b00,0b00,false],
  [0b00,0b01,false],
  [0b00,0b10,false],
  [0b00,0b11,false],
  [0b01,0b00,false],
  [0b01,0b01,true],
  [0b01,0b10,false],
  [0b01,0b11,false],
  [0b10,0b00,false],
  [0b10,0b01,false],
  [0b10,0b10,true],
  [0b10,0b11,false],
  [0b11,0b00,false],
  [0b11,0b01,true],
  [0b11,0b10,true],
  [0b11,0b11,true],
]
$or = [
  [0b00,0b00,false],
  [0b00,0b01,true],
  [0b00,0b10,true],
  [0b00,0b11,true],
  [0b01,0b00,true],
  [0b01,0b01,true],
  [0b01,0b10,true],
  [0b01,0b11,true],
  [0b10,0b00,true],
  [0b10,0b01,true],
  [0b10,0b10,true],
  [0b10,0b11,true],
  [0b11,0b00,true],
  [0b11,0b01,true],
  [0b11,0b10,true],
  [0b11,0b11,true],
]
$xor = [
  [0b00,0b00,false],
  [0b00,0b01,true],
  [0b00,0b10,true],
  [0b00,0b11,true],
  [0b01,0b00,true],
  [0b01,0b01,false],
  [0b01,0b10,true],
  [0b01,0b11,true],
  [0b10,0b00,true],
  [0b10,0b01,true],
  [0b10,0b10,false],
  [0b10,0b11,true],
  [0b11,0b00,true],
  [0b11,0b01,true],
  [0b11,0b10,true],
  [0b11,0b11,false],
]

require_relative '../lib/mug/bittest'
class Test_bittest < Test::Unit::TestCase

  def test_and?
    $and_any.each do |l,r,x|
      assert_equal( x, l.and?(r), "#{l} & #{r} #{x ? '=' : '!'}= 0" )
    end
    assert_raise( ArgumentError ) { 1.and?(0, :test=>:invalid) }
  end
  def test_and_any
    $and_any.each do |l,r,x|
      assert_equal( x, l.and?(r, :test=>:any), "#{l} & #{r} #{x ? '!' : '='}= 0" )
    end
  end
  def test_and_all
    $and_all.each do |l,r,x|
      assert_equal( x, l.and?(r, :test=>:all), "#{l} & #{r} #{x ? '=' : '!'}= #{r}" )
    end
  end

  def test_and_any?
    $and_any.each do |l,r,x|
      assert_equal( x, l.and_any?(r), "#{l} & #{r} #{x ? '!' : '='}= 0" )
    end
  end
  def test_and_all?
    $and_all.each do |l,r,x|
      assert_equal( x, l.and_all?(r), "#{l} & #{r} #{x ? '=' : '!'}= #{r}" )
    end
  end

  def test_or?
    $or.each do |l,r,x|
      assert_equal( x, l.or?(r), "#{l} | #{r} #{x ? '=' : '!'}= 0" )
    end
  end

  def test_xor?
    $xor.each do |l,r,x|
      assert_equal( x, l.xor?(r), "#{l} ^ #{r} #{x ? '!' : '='}= 0" )
    end
  end

end

