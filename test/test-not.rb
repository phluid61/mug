require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/not'
class Test_not < Test::Unit::TestCase
  def test_not__noargs
    [
      [true,  false],
      [99,    false],
      [false, true],
      [nil,   true],
    ].each do |o, x|
      assert_equal( x, o.not, "#{o.inspect}.not should be #{x}" )
    end
  end
  def test_not__method
    [
      [[],   false],
      [[99], true],
    ].each do |o, x|
      assert_equal( x, o.not(:empty?), "#{o.inspect}.not(:empty?) should be #{x}" )
    end
  end
  def test_not__method2
    [
      [[],   false],
      [[99], true],
    ].each do |o, x|
      assert_equal( x, o.not(&:empty?), "#{o.inspect}.not(&:empty?) should be #{x}" )
    end
  end
  def test_not__args
    [
      [1,  true],
      [0,  true],
      [-1, false],
    ].each do |o, x|
      assert_equal( x, o.not(:<, 0), "#{o.inspect}.not(:<, 0) should be #{x}" )
    end
  end

  def test_not__block
    [
      [1,  true],
      [0,  true],
      [-1, false],
    ].each do |o, x|
      assert_equal( x, o.not {|obj| obj < 0 }, "#{o.inspect}.not{|obj|obj<0} should be #{x}" )
    end
  end
  def test_not__method_block
    [
      [[],     true],
      [[0,-1], true],
      [[0,99], false],
    ].each do |o, x|
      assert_equal( x, o.not(:any?) {|item| item > 0 }, "#{o.inspect}.not(:any?){|item|item>0} should be #{x}" )
    end
  end
end
