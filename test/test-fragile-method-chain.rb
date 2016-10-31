require 'test/unit'
$VERBOSE = true

module FMCTest
  class A
    def initialize; @b = B.new; end
    attr_accessor :b
  end

  class B
    def initialize; @c = C.new; end
    attr_accessor :c
  end

  class C
    def to_i; 1; end
  end
end

def false.c
  2
end

require_relative '../lib/mug/fragile-method-chain'
class Test_fmc < Test::Unit::TestCase
  def test_fmc_nil
    a = FMCTest::A.new
    assert_equal( 1, a._?.b.c.to_i._! )
    assert_equal( 1, a._?.b.c._!.to_i )
    assert_equal( 1, a._?.b._!.c.to_i )
    a.b.c = nil
    assert_nil( a._?.b.c.to_i._! )
    assert_equal( 0, a._?.b.c._!.to_i )
    assert_equal( 0, a._?.b._!.c.to_i )
    a.b = nil
    assert_nil( a._?.b.c.to_i._! )
    assert_equal( 0, a._?.b.c._!.to_i )
    assert_raise(NoMethodError) { a._?.b._!.c.to_i }
    a = nil
    assert_nil( a._?.b.c.to_i._! )
  end
  def test_fmc_false
    a = FMCTest::A.new
    assert_equal( 1, a._?.b.c.to_i._! )
    assert_equal( 1, a._?.b.c._!.to_i )
    assert_equal( 1, a._?.b._!.c.to_i )
    a.b.c = false
    assert_equal( false, a._?.b.c.to_i._! )
    assert_raise(NoMethodError) { a._?.b.c._!.to_i }
    assert_raise(NoMethodError) { a._?.b._!.c.to_i }
    a.b = false
    assert_equal( false, a._?.b.c.to_i._! )
    assert_raise(NoMethodError) { a._?.b.c._!.to_i }
    assert_equal( 2, a._?.b._!.c.to_i )
    a = false
    assert_equal( false, a._?.b.c.to_i._! )
    assert_raise(NoMethodError) { a._?.b.c._!.to_i }
    assert_equal( 2, a._?.b._!.c.to_i )
  end
  def test_fmc_nested
    a = FMCTest::A.new
    assert_equal( 1, a._?.b._?.c._!.to_i._! )
    a.b.c = false
    assert_equal( false, a._?.b._?.c._!.to_i._! )
    a.b = false
    assert_equal( false, a._?.b._?.c._!.to_i._! )
    a = false
    assert_equal( false, a._?.b._?.c._!.to_i._! )
  end
end

