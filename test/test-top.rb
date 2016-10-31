require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/top'
class Test_and_or < Test::Unit::TestCase

  def test_top
    a = [1,3,5,2,4,3]
    assert_equal( [5], a.top )
    assert_equal( [5,4,3], a.top(3) )
    assert_equal( [5,4,3,3,2,1], a.top(100) )
  end
  def test_bottom
    a = [3,1,4,3,2,5]
    assert_equal( [1], a.bottom )
    assert_equal( [1,2,3], a.bottom(3) )
    assert_equal( [1,2,3,3,4,5], a.bottom(100) )
  end

  def test_top__block
    a = [1,3,5,2,4,3]
    b = proc{|x,y| y<=>x }
    assert_equal( [1], a.top(&b) )
    assert_equal( [1,2,3], a.top(3,&b) )
    assert_equal( [1,2,3,3,4,5], a.top(100,&b) )
  end
  def test_bottom__block
    a = [3,1,4,3,2,5]
    b = proc{|x,y| y<=>x }
    assert_equal( [5], a.bottom(&b) )
    assert_equal( [5,4,3], a.bottom(3,&b) )
    assert_equal( [5,4,3,3,2,1], a.bottom(100,&b) )
  end

  def test_top_by
    a = [1,3,5,2,4,3]
    b = proc{|x| x % 3 }
    assert_equal( [5], a.top_by(&b) )
    assert_equal( [5,2,1], a.top_by(3, &b) )
    assert_equal( [5,2,1,4,3,3], a.top_by(100, &b) )
  end
  def test_bottom_by
    a = [3,1,4,3,2,5]
    b = proc{|x| x % 3 }
    assert_equal( [3], a.bottom_by(&b) )
    assert_equal( [3,3,1], a.bottom_by(3, &b) )
    assert_equal( [3,3,1,4,2,5], a.bottom_by(100, &b) )
  end

  def test_top_by__noblock
    a = [1,3,5,2,4,3]
    b = proc{|x| x % 3 }
    assert_equal( [5], a.top_by.each(&b) )
    assert_equal( [5,2,1], a.top_by(3).each(&b) )
    assert_equal( [5,2,1,4,3,3], a.top_by(100).each(&b) )
  end
  def test_bottom_by__noblock
    a = [3,1,4,3,2,5]
    b = proc{|x| x % 3 }
    assert_equal( [3], a.bottom_by.each(&b) )
    assert_equal( [3,3,1], a.bottom_by(3).each(&b) )
    assert_equal( [3,3,1,4,2,5], a.bottom_by(100).each(&b) )
  end

  def test_topBANG
    a = [1,3,5,2,4,3]
    a.top!(3)
    assert_equal( [5,4,3], a )
  end
  def test_bottomBANG
    a = [3,1,4,3,2,5]
    a.bottom!(3)
    assert_equal( [1,2,3], a )
  end

  def test_topBANG__block
    a = [1,3,5,2,4,3]
    b = proc{|x,y| y<=>x }
    a.top!(3, &b)
    assert_equal( [1,2,3], a )
  end
  def test_bottomBANG__block
    a = [3,1,4,3,2,5]
    b = proc{|x,y| y<=>x }
    a.bottom!(3, &b)
    assert_equal( [5,4,3], a )
  end

  def test_top_byBANG
    a = [1,3,5,2,4,3]
    b = proc{|x| x % 3 }
    a.top_by!(3, &b)
    assert_equal( [5,2,1], a )
  end
  def test_bottom_byBANG
    a = [3,1,4,3,2,5]
    b = proc{|x| x % 3 }
    a.bottom_by!(3, &b)
    assert_equal( [3,3,1], a )
  end

  def test_top_byBANG__noblock
    a = [1,3,5,2,4,3]
    b = proc{|x| x % 3 }
    a.top_by!(3).each(&b)
    assert_equal( [5,2,1], a )
  end
  def test_bottom_byBANG__noblock
    a = [3,1,4,3,2,5]
    b = proc{|x| x % 3 }
    a.bottom_by!(3).each(&b)
    assert_equal( [3,3,1], a )
  end

end

