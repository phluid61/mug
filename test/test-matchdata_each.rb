require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/matchdata/each'
class Test_matchdata_each < Test::Unit::TestCase
  def test__matchdata__each
    str = 'a12b'
    [
      [/(    \d)(    \d)/x.match(str), %w[ 12 1 2 ]],
      [/(?<x>\d)(?<y>\d)/x.match(str), %w[ 12 1 2 ]],
      [/(    \d)(?<y>\d)/x.match(str), %w[ 12   2 ]], # ):
    ].each do |m, x|
      assert_equal( x, m.each.to_a )
    end
  end
  def test__matchdata__each_capture
    str = 'a12b'
    [
      [/(    \d)(    \d)/x.match(str), [[ 1 ,'1'],[ 2 ,'2']]],
      [/(?<x>\d)(?<y>\d)/x.match(str), [['x','1'],['y','2']]],
      [/(    \d)(?<y>\d)/x.match(str), [          ['y','2']]], # ):
    ].each do |m, x|
      assert_equal( x, m.each_capture.to_a )
    end
  end
  def test__matchdata__each_named_capture
    str = 'a12b'
    [
      [/(    \d)(    \d)/x.match(str), [                   ]],
      [/(?<x>\d)(?<y>\d)/x.match(str), [['x','1'],['y','2']]],
      [/(    \d)(?<y>\d)/x.match(str), [          ['y','2']]],
    ].each do |m, x|
      assert_equal( x, m.each_named_capture.to_a )
    end
  end
  def test__matchdata__each_positional_capture
    str = 'a12b'
    [
      [/(    \d)(    \d)/x.match(str), [[ 1, '1'],[ 2 ,'2']]],
      [/(?<x>\d)(?<y>\d)/x.match(str), [                   ]],
      [/(    \d)(?<y>\d)/x.match(str), [                   ]], # D:
    ].each do |m, x|
      assert_equal( x, m.each_positional_capture.to_a )
    end
  end
  def test__matchdata__each_positional_capture2
    str = 'a12b'
    [
      [/(    \d)(    \d)/x.match(str), [[ 1, '1'],[ 2 ,'2']]],
      [/(?<x>\d)(?<y>\d)/x.match(str), [[ 1, '1'],[ 2 ,'2']]],
      [/(    \d)(?<y>\d)/x.match(str), [[ 1, '2']]],           # ):
    ].each do |m, x|
      assert_equal( x, m.each_positional_capture(include_names: true).to_a )
    end
  end
end

