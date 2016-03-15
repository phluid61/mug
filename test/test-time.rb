require 'test/unit'
$VERBOSE = true

$past   = Time.new 1970, 1, 1, 0, 0, 0
$future = Time.new 2170, 1, 1, 0, 0, 0

require_relative '../lib/mug/time'
class Test_time < Test::Unit::TestCase

  def test__to_now
    assert_kind_of( Numeric, $past.to_now )
    assert_operator( 0.0, :<, $past.to_now )
    assert_operator( 0.0, :>, $future.to_now )
    assert_equal( 0, Time.now.to_now.to_i ) # racey
  end

  def test__from_now
    assert_kind_of( Numeric, $future.from_now )
    assert_operator( 0.0, :>, $past.from_now )
    assert_operator( 0.0, :<, $future.from_now )
    assert_equal( 0, Time.now.from_now.to_i ) # racey
  end

  def test__until
    assert_kind_of( Numeric, Time.until($future) )
    assert_operator( 0.0, :>, Time.until($past) )
    assert_operator( 0.0, :<, Time.until($future) )
    assert_equal( 0, Time.until(Time.now).to_i ) # racey
  end

  def test__since
    assert_kind_of( Numeric, Time.since($past) )
    assert_operator( 0.0, :<, Time.since($past) )
    assert_operator( 0.0, :>, Time.since($future) )
    assert_equal( 0, Time.since(Time.now).to_i ) # racey
  end

end

