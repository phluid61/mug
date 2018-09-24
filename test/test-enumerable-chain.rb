require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/enumerable/chain'
class Test_enumerable_chain < Test::Unit::TestCase
  def test_chain
    a = [1, 2, 3, 4].each_with_index
    b = [5, 6].each_with_index
    c = [7, 8].each_with_index
    expect = [
      [1,0], [2,1], [3,2], [4,3],
      [5,0], [6,1],
      [7,0], [8,1],
    ]

    result = []
    a.chain(b, c) do |*a|
      result << a
    end

    assert_equal( expect, result )
  end

  def test_chain__noblock
    a = [1, 2, 3, 4].each_with_index
    b = [5, 6].each_with_index
    c = [7, 8].each_with_index
    expect = [
      [1,0], [2,1], [3,2], [4,3],
      [5,0], [6,1],
      [7,0], [8,1],
    ]

    enum = a.chain(b, c)
    assert_kind_of( Enumerator, enum )

    result = []
    enum.each do |*a|
      result << a
    end

    assert_equal( expect, result )
  end

  def test_chain0
    a = [1, 2, 3, 4].each_with_index
    b = [5, 6, 7, 8].each_with_index
    expect = [
      [1,0], [2,1], [3,2], [4,3],
      [5,0], [6,1], [7,2], [8,3],
    ]

    result = []
    Enumerable.chain(a, b) do |*a|
      result << a
    end

    assert_equal( expect, result )
  end

  def test_chain0__noblock
    a = [1, 2, 3, 4].each_with_index
    b = [5, 6, 7, 8].each_with_index
    expect = [
      [1,0], [2,1], [3,2], [4,3],
      [5,0], [6,1], [7,2], [8,3],
    ]

    enum = Enumerable.chain(a, b)
    assert_kind_of( Enumerator, enum )

    result = []
    enum.each do |*a|
      result << a
    end

    assert_equal( expect, result )
  end
end

