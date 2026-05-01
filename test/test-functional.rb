require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/functional'

class Test_functional_compose < Test::Unit::TestCase
  def test_compose__readme_example
    prc = lambda {|x| x.inspect }
    prc2 = prc.compose(:to_s, :length)
    assert_equal( 3, prc2[123] )
    assert_equal( 5, prc2['abc'] )
  end
  def test_compose__empty
    prc = lambda {|x| x }
    assert_same( prc, prc.compose )
  end
  def test_compose__single
    prc = lambda {|x| x + 1 }
    prc2 = prc.compose(:abs)
    assert_equal( 4, prc2[-5] )
  end
end

class Test_functional_precompose < Test::Unit::TestCase
  def test_precompose__readme_example
    prc = lambda {|x| x.inspect }
    prc2 = prc.precompose(:to_s, :length)
    assert_equal( '3', prc2[123] )
    assert_equal( '3', prc2['abc'] )
  end
  def test_precompose__empty
    prc = lambda {|x| x }
    assert_same( prc, prc.precompose )
  end
  def test_precompose__single
    prc = lambda {|x| x * 2 }
    prc2 = prc.precompose(:to_i)
    assert_equal( 246, prc2['123'] )
  end
end

class Test_functional_mapply < Test::Unit::TestCase
  def test_mapply__basic
    prc = lambda {|x| x.to_s }
    assert_equal( ['1', '2', '3'], prc.mapply(1, 2, 3) )
  end
  def test_mapply__equivalent_to_map
    prc = lambda {|x| x * 2 }
    args = [1, 2, 3, 4]
    assert_equal( args.map(&prc), prc.mapply(*args) )
  end
  def test_mapply__empty
    prc = lambda {|x| x }
    assert_equal( [], prc.mapply )
  end
end

class Test_functional_memoize < Test::Unit::TestCase
  def test_memoize__caches_result
    call_count = 0
    prc = lambda do |x|
      call_count += 1
      x * 2
    end
    memo = prc.memoize
    assert_equal( 4, memo.call(2) )
    assert_equal( 1, call_count )
    assert_equal( 4, memo.call(2) )
    assert_equal( 1, call_count )
  end
  def test_memoize__different_args
    call_count = 0
    prc = lambda do |x|
      call_count += 1
      x * 2
    end
    memo = prc.memoize
    assert_equal( 4, memo.call(2) )
    assert_equal( 6, memo.call(3) )
    assert_equal( 2, call_count )
  end
  def test_memoise__alias
    prc = lambda {|x| x }
    assert_equal( prc.method(:memoize), prc.method(:memoise) )
  end
end

class Test_functional_trans < Test::Unit::TestCase
  def test_trans__reorder
    prc = lambda {|a, b, c| [a, b, c] }
    prc2 = prc.trans(2, 0, 1)
    assert_equal( [:c, :a, :b], prc2.call(:a, :b, :c) )
  end
  def test_trans__duplicate_index
    prc = lambda {|a, b| [a, b] }
    prc2 = prc.trans(0, 0)
    assert_equal( [:x, :x], prc2.call(:x, :y) )
  end
  def test_trans__capped_by_args
    prc = lambda {|*a| a }
    prc2 = prc.trans(2, 1, 0)
    assert_equal( [nil, :b], prc2.call(:a, :b) )
  end
  def test_trans__capped_by_indices
    prc = lambda {|*a| a }
    prc2 = prc.trans(1, 0)
    assert_equal( [:b, :a], prc2.call(:a, :b, :c) )
  end
end

class Test_functional_zipmap < Test::Unit::TestCase
  def test_zipmap__readme_example
    printer = lambda {|*x| x }
    mapped = printer.zipmap(:upcase, :downcase, :to_sym)
    assert_equal( ['HELLO', 'there', :Everyone], mapped.call('Hello', 'There', 'Everyone') )
  end
  def test_zipmap__nil_passthrough
    prc = lambda {|a, b| [a, b] }
    prc2 = prc.zipmap(nil, :to_s)
    assert_equal( [42, '42'], prc2.call(42, 42) )
  end
  def test_zipmap__callable
    doubler = lambda {|x| x * 2 }
    prc = lambda {|a, b| [a, b] }
    prc2 = prc.zipmap(doubler, nil)
    assert_equal( [10, 5], prc2.call(5, 5) )
  end
  def test_zipmap__type_error
    prc = lambda {|a| a }
    prc2 = prc.zipmap(123)
    assert_raise( TypeError ) { prc2.call('x') }
  end
end

class Test_functional_juxt < Test::Unit::TestCase
  def test_juxt__readme_example
    func = Proc.juxt :upcase, :downcase, :length
    assert_equal( ['ABC', 'abc', 3], func.call('AbC') )
  end
  def test_juxt__with_procs
    doubler = lambda {|x| x * 2 }
    negator = lambda {|x| -x }
    func = Proc.juxt(doubler, negator)
    assert_equal( [10, -5], func.call(5) )
  end
end

class Test_functional_identity < Test::Unit::TestCase
  def test_identity__returns_same_object
    func = Proc.identity
    obj = Object.new
    assert_same( obj, func.call(obj) )
  end
  def test_identity__with_values
    func = Proc.identity
    assert_equal( 42, func.call(42) )
    assert_equal( 'hello', func.call('hello') )
    assert_nil( func.call(nil) )
  end
end

class Test_functional_const < Test::Unit::TestCase
  def test_const__returns_constant
    obj = Object.new
    func = Proc.const(obj)
    assert_same( obj, func.call )
    assert_same( obj, func.call(1, 2, 3) )
  end
  def test_const__same_object_mutations_stick
    ary = [1, 2, 3]
    func = Proc.const(ary)
    func.call.push(4)
    assert_equal( [1, 2, 3, 4], func.call )
  end
end

class Test_functional_unfold < Test::Unit::TestCase
  def test_unfold__counting
    enum = Enumerator.unfold(1) {|n| [n, n + 1] }
    assert_equal( [1, 2, 3, 4, 5], enum.take(5) )
  end
  def test_unfold__fibonacci
    enum = Enumerator.unfold([0, 1]) {|(a, b)| [a, [b, a + b]] }
    assert_equal( [0, 1, 1, 2, 3], enum.take(5) )
  end
  def test_unfold__termination
    enum = Enumerator.unfold(1) {|n| n <= 3 ? [n, n + 1] : nil }
    assert_equal( [1, 2, 3], enum.to_a )
  end
  def test_unfold__no_block
    assert_raise( ArgumentError ) { Enumerator.unfold(1) }
  end
end
