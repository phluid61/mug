require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/apply'
class Test_apply < Test::Unit::TestCase

  class Foo
    def bar a, b
      (a||0) + (b||0)
    end
  end

  def test_apply_proc
    prc = proc{|a,b,*c| (a||0) + (b||0) + c.inject(0, &:+) }
    p1 = prc.apply(1)
    assert( p1.is_a? Proc )
    assert_equal( 3, p1.apply(2) )
    assert_equal( 3, prc.apply(1,2) )
    assert_equal( 15, prc.apply(1,2,3,4,5) )
  end
  def test_apply_lambda
    lmb = lambda{|a,b,c| (a||0) + (b||0) + (c||0) }

    l1 = lmb.apply(1)
    assert( l1.is_a? Proc )

    l2 = l1.apply(2)
    assert( l2.is_a? Proc )

    assert_equal( 6, l2.apply(3) )
    assert_equal( 6, l1.apply(2,3) )

    assert_raise( ArgumentError ){ l2.apply(3, 4) }
    assert_raise( ArgumentError ){ lmb.apply(1, 2, 3, 4) }
  end
  def test_apply_method
    m1 = 1.method :+
    assert_equal( 3, m1.apply(2) )
    assert_raise( ArgumentError ){ m1.apply(2,3) }

    m2 = Foo.new.method :bar
    l1 = m2.apply(1)
    assert( l1.is_a? Proc )

    assert_equal( 3, l1.apply(2) )
    assert_equal( 3, m2.apply(1,2) )

    assert_raise( ArgumentError ){ l1.apply(2, 3) }
    assert_raise( ArgumentError ){ m2.apply(1, 2, 3) }
  end
  def test_curry_method
    m1 = 1.method :+
    assert( m1.curry.is_a? Proc )
    assert( m1.curry(1).is_a? Proc )
    assert_raise( ArgumentError ){ m1.curry(2) }
  end
end
