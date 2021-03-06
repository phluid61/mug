require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/maybe'
class Test_maybe < Test::Unit::TestCase

  module MaybeTest
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

  def self.startup
    class << false
      def c
        2
      end
    end
  end
  def self.shutdown
    class << false
      undef c
    end
  end

  def test_maybe_block_nil
    a = MaybeTest::A.new
    assert_equal( 1, a.maybe{ b.maybe{ c } }.to_i )
    assert_equal( 1, a.maybe{ b.c.to_i } )
    assert_equal( 1, a.maybe{ b }.c.to_i )
    a.b.c = nil
    assert_equal( 0, a.maybe{ b.maybe{ c } }.to_i )
    assert_equal( 0, a.maybe{ b.c.to_i } )
    assert_equal( 0, a.maybe{ b }.c.to_i )
    a.b = nil
    assert_nil( a.maybe{ b.maybe{ c } } )
    assert_raise(NoMethodError) { a.maybe{ b.c } }
    assert_raise(NoMethodError) { a.maybe{ b }.c }
    a = nil
    assert_nil( a.maybe{ b.maybe{ c } } )
    assert_nil( a.maybe{ b.c } )
    assert_raise(NoMethodError) { a.maybe{ b }.c }
  end
  def test_maybe_block_false
    a = MaybeTest::A.new
    assert_equal( 1, a.maybe{ b.maybe{ c } }.to_i )
    assert_equal( 1, a.maybe{ b.c.to_i } )
    assert_equal( 1, a.maybe{ b }.c.to_i )
    a.b.c = false
    assert_raise(NoMethodError) { a.maybe{ b.maybe{ c } }.to_i }
    assert_raise(NoMethodError) { a.maybe{ b.c.to_i } }
    assert_raise(NoMethodError) { a.maybe{ b }.c.to_i }
    a.b = false
    assert_equal( false, a.maybe{ b.maybe{ c } } )
    assert_equal( 2, a.maybe{ b.c } )
    assert_equal( 2, a.maybe{ b }.c )
    a = false
    assert_equal( false, a.maybe{ b.maybe{ c } } )
    assert_equal( false, a.maybe{ b.c } )
    assert_equal( 2, a.maybe{ b }.c )
  end
  def test_maybe_delegator_nil
    a = MaybeTest::A.new
    assert_equal( 1, a.maybe.b.maybe.c.to_i )
    assert_equal( 1, a.maybe.b.c.to_i )
    a.b.c = nil
    assert_nil( a.maybe.b.maybe.c )
    assert_nil( a.maybe.b.c )
    a.b = nil
    assert_nil( a.maybe.b.maybe.c )
    assert_raise(NoMethodError) { a.maybe.b.c }
    a = nil
    assert_nil( a.maybe.b.maybe.c )
    assert_raise(NoMethodError) { a.maybe.b.c }
  end
  def test_maybe_delegator_false
    a = MaybeTest::A.new
    assert_equal( 1, a.maybe.b.maybe.c.to_i )
    assert_equal( 1, a.maybe.b.c.to_i )
    a.b.c = false
    assert_equal( false, a.maybe.b.maybe.c )
    assert_equal( false, a.maybe.b.c )
    a.b = false
    assert_equal( false, a.maybe.b.maybe.c )
    assert_equal( 2, a.maybe.b.c )
    a = false
    assert_equal( false, a.maybe.b.maybe.c )
    assert_equal( 2, a.maybe.b.c )
  end
end
