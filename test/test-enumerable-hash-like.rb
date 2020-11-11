require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/enumerable/hash-like'
class Test_hashlike < Test::Unit::TestCase

  class HashLikeEnum
    def each
      return enum_for(:each) unless block_given?
      yield 'a'
      yield 'b'
      yield 'c'
      yield 'd'
    end
    include Enumerable
  end

  def test__each_pair__block
    my_enum = HashLikeEnum.new
    expect = [[0, 'a'], [1, 'b'], [2, 'c'], [3, 'd']]

    my_enum.each_pair do |key, value|
      exp = expect.shift
      assert_equal(exp, [key, value])
    end
  end

  def test__each_pair
    my_enum = HashLikeEnum.new
    expect = [[0, 'a'], [1, 'b'], [2, 'c'], [3, 'd']]

    enm = my_enum.each_pair

    enm.each do |key, value|
      exp = expect.shift
      assert_equal(exp, [key, value])
    end
  end

  def test__each_key__block
    my_enum = HashLikeEnum.new
    expect = [0, 1, 2, 3]

    my_enum.each_key do |key|
      exp = expect.shift
      assert_equal(exp, key)
    end
  end

  def test__each_key
    my_enum = HashLikeEnum.new
    expect = [0, 1, 2, 3]

    enm = my_enum.each_key

    enm.each do |key|
      exp = expect.shift
      assert_equal(exp, key)
    end
  end

  def test__each_value__block
    my_enum = HashLikeEnum.new
    expect = %w[a b c d]

    my_enum.each_value do |value|
      exp = expect.shift
      assert_equal(exp, value)
    end
  end

  def test__each_value
    my_enum = HashLikeEnum.new
    expect = %w[a b c d]

    enm = my_enum.each_value

    enm.each do |value|
      exp = expect.shift
      assert_equal(exp, value)
    end
  end

  def test__fetch
    my_enum = HashLikeEnum.new

    assert_raise(ArgumentError) { my_enum.fetch }

    assert_equal('a', my_enum.fetch(0))
    assert_equal('d', my_enum.fetch(3))
    assert_raise(KeyError) { my_enum.fetch(5) }
    assert_raise(KeyError) { my_enum.fetch(-1) }
    assert_raise(KeyError) { my_enum.fetch('not a number') }
  end

  def test__fetch__default
    my_enum = HashLikeEnum.new
    default = 'z'

    assert_equal('a', my_enum.fetch(0, default))
    assert_equal('d', my_enum.fetch(3, default))
    assert_equal(default, my_enum.fetch(5, default))
    assert_equal(default, my_enum.fetch(-1, default))
    assert_equal(default, my_enum.fetch('not a number', default))
  end

  def test__fetch__block
    my_enum = HashLikeEnum.new

    block = proc {|key| key }

    assert_equal('a', my_enum.fetch(0, &block))
    assert_equal('d', my_enum.fetch(3, &block))
    assert_equal(5, my_enum.fetch(5, &block))
    assert_equal(-1, my_enum.fetch(-1, &block))
    assert_equal('not a number', my_enum.fetch('not a number', &block))
  end

  def test__fetch__default_block
    my_enum = HashLikeEnum.new
    default = 'z'

    block = proc {|key| key }

    assert_equal('a', my_enum.fetch(0, default, &block))
    assert_equal('d', my_enum.fetch(3, default, &block))
    assert_equal(default, my_enum.fetch(5, default, &block))
    assert_equal(default, my_enum.fetch(-1, default, &block))
    assert_equal(default, my_enum.fetch('not a number', default, &block))
  end

  def test__fetch_values
    my_enum = HashLikeEnum.new

    assert_equal(%w[a d], my_enum.fetch_values(0, 3))
    assert_equal(%w[a d a d], my_enum.fetch_values(0, 3, 0, 3))
    assert_raise(KeyError) { my_enum.fetch_values(5) }
    assert_raise(KeyError) { my_enum.fetch_values(0, 3, 5) }
  end

  def test__fetch_values__block
    my_enum = HashLikeEnum.new

    block = proc {|key| key }

    assert_equal(%w[a d], my_enum.fetch_values(0, 3, &block))
    assert_equal(%w[a d a d], my_enum.fetch_values(0, 3, 0, 3, &block))
    assert_equal([5], my_enum.fetch_values(5, &block))
    assert_equal(['a', 'd', 5], my_enum.fetch_values(0, 3, 5, &block))
  end

  def test__key
    my_enum = HashLikeEnum.new

    assert_equal(0, my_enum.key('a'))
    assert_equal(3, my_enum.key('d'))
    assert_nil(my_enum.key('missing'))
  end

  def test__keys
    my_enum = HashLikeEnum.new
    expect = [0, 1, 2, 3]

    assert_equal(expect, my_enum.keys)
  end

  def test__length
    my_enum = HashLikeEnum.new
    expect = 4

    assert_equal(expect, my_enum.length)
  end

  def test__member?
    my_enum = HashLikeEnum.new

    assert(my_enum.member?(0))
    assert(my_enum.member?(3))
    assert(!my_enum.member?(5))
    assert(!my_enum.member?(-1))
    assert(!my_enum.member?('not a number'))
  end

  def test__slice
    my_enum = HashLikeEnum.new

    assert_equal({0=>'a', 3=>'d'}, my_enum.slice(0, 3))
    assert_equal({0=>'a', 3=>'d'}, my_enum.slice(0, 3, 0))
    assert_equal({0=>'a', 3=>'d'}, my_enum.slice(0, 3, 5))
    assert_equal({0=>'a', 3=>'d'}, my_enum.slice(0, 3, -1))
    assert_equal({0=>'a', 3=>'d'}, my_enum.slice(0, 3, 'not a number'))
    assert_equal({}, my_enum.slice())
  end

  def test__transform_keys
    my_enum = HashLikeEnum.new

    block = proc {|key| "_#{key}_" }

    enm = my_enum.transform_keys
    assert_equal({'_0_'=>'a', '_1_'=>'b', '_2_'=>'c', '_3_'=>'d'}, enm.each(&block))
  end

  def test__transform_keys__block
    my_enum = HashLikeEnum.new

    block = proc {|key| "_#{key}_" }

    assert_equal({'_0_'=>'a', '_1_'=>'b', '_2_'=>'c', '_3_'=>'d'}, my_enum.transform_keys(&block))
  end

  def test__transform_values
    my_enum = HashLikeEnum.new

    block = proc {|value| value.upcase }

    enm = my_enum.transform_values
    assert_equal({0=>'A', 1=>'B', 2=>'C', 3=>'D'}, enm.each(&block))
  end

  def test__transform_values__block
    my_enum = HashLikeEnum.new

    block = proc {|value| value.upcase }

    assert_equal({0=>'A', 1=>'B', 2=>'C', 3=>'D'}, my_enum.transform_values(&block))
  end

  def test__values
    my_enum = HashLikeEnum.new

    assert_equal(%w[a b c d], my_enum.values)
  end

  def test__values_at
    my_enum = HashLikeEnum.new

    assert_equal(%w[a d], my_enum.values_at(0, 3))
    assert_equal(%w[a d a], my_enum.values_at(0, 3, 0))
    assert_equal(['a',nil,'d'], my_enum.values_at(0, 5, 3))
    assert_equal(['a',nil,'d'], my_enum.values_at(0, -1, 3))
    assert_equal(['a',nil,'d'], my_enum.values_at(0, 'not a number', 3))
    assert_equal([], my_enum.values_at())
  end
end

