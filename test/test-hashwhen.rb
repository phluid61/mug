require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/hash/when'
class Test_hashwhen < Test::Unit::TestCase
  def test_hashwhen
    h = {
      /foo/ => "FOO",
      /bar/ => "BAR",
    }
    h.default = "DEFAULT"

    assert_equal( 'FOO', h.when("xfoob") )
    assert_equal( 'BAR', h.when("barbar") )
    assert_equal( 'DEFAULT', h.when("qux") )
  end
  def test_hashwhen_proc
    h = Hash.new {|_,k| k.to_s.upcase }
    h[/foo/] = 'FOO'
    h[/bar/] = 'BAR'

    assert_equal( 'FOO', h.when("xfoob") )
    assert_equal( 'BAR', h.when("barbar") )
    assert_equal( 'QUX', h.when("qux") )
  end
end

