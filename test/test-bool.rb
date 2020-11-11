require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/bool'
class Test_bool < Test::Unit::TestCase

  class MyEnum
    include Enumerable
    def initialize(*a) @a=a; end
    def each(&b) @a.each(&b); end
  end

  if RUBY_VERSION.to_i >= 2
    TRUTHY = [ 1, 1.0, Float::INFINITY, -Float::INFINITY, (1<<100).coerce(1).first, Rational(1,1), "x", [1], {1=>1}, MyEnum.new(1), [1].each ]
    FALSY  = [ 0, 0.0, -0.0, Float::NAN, (1<<100).coerce(0).first, Rational(0,1), "", [], {}, MyEnum.new, [].each, RuntimeError.new ]
  else
    TRUTHY = [ 1, 1.0, Float::INFINITY, -Float::INFINITY, (1<<100).coerce(1).first, Rational(1,1), "x", [1], {1=>1}, MyEnum.new(1) ]
    FALSY  = [ 0, 0.0, -0.0, Float::NAN, (1<<100).coerce(0).first, Rational(0,1), "", [], {}, MyEnum.new, RuntimeError.new ]
  end

  alias assert_true assert
  def assert_false val, msg=UNASSIGNED
    assert !val, msg
  end
  def true_msg o, m=nil
    m &&= ".#{m}"
    "#{o.inspect}#{m} should be true"
  end
  def false_msg o, m=nil
    m &&= ".#{m}"
    "#{o.inspect}#{m} should be false"
  end

  def test_Bool
    assert_true( Bool(true), true_msg(true) )
    assert_false( Bool(false), false_msg(false) )
    assert_false( Bool(nil), false_msg(false) )
    TRUTHY.each do |o|
      assert_true( Bool(o), true_msg(o) )
    end
    FALSY.each do |o|
      assert_true( Bool(o), true_msg(o) )
    end
  end

  def test_to_bool
    assert_true( true.to_bool, true_msg(true,'to_bool') )
    assert_false( false.to_bool, false_msg(false,'to_bool') )
    assert_false( nil.to_bool, false_msg(nil,'to_bool') )
    TRUTHY.each do |o|
      assert_true( o.to_bool, true_msg(o,'to_bool') )
    end
    FALSY.each do |o|
      assert_true( o.to_bool, true_msg(o,'to_bool') )
    end
  end

  def test_to_b
    assert_true( true.to_b, true_msg(true,'to_b') )
    assert_false( false.to_b, false_msg(false,'to_b') )
    assert_false( nil.to_b, false_msg(nil,'to_b') )
    TRUTHY.each do |o|
      assert_true( o.to_b, true_msg(o,'to_b') )
    end
    FALSY.each do |o|
      assert_false( o.to_b, false_msg(o,'to_b') )
    end
  end
end

