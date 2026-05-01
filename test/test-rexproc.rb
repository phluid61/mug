require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/rexproc'
class Test_rexproc < Test::Unit::TestCase
  def test_rexproc
    a = %w[foo bar baz]
    assert_equal( %w[bar baz], a.select(&/\Ab/) )
    assert_equal( %w[foo],     a.reject(&/\Ab/) )
    assert_equal(  %[bar],     a.find(  &/\Ab/) )
  end
end

# vim: set ts=2 sts=2 sw=2 expandtab:
