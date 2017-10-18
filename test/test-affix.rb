require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/affix'
class Test_affix < Test::Unit::TestCase

  def test_affix
    str = 'XXX'
    pre = '+++'
    suf = '---'

    a = "#{pre}#{str}#{suf}"
    b = "#{pre}#{str}"
    c =       "#{str}#{suf}"

    assert_equal( a, str.affix(pre, suf) )
    assert_equal( b, str.prefix(pre) )
    assert_equal( c, str.suffix(suf) )
  end

  def test_affix_bang
    str = ''
    pre = '+'
    suf = '-'

    3.times do |i|
      numpre = i * 2
      numsuf = i * 2

      str.affix! pre, suf
      numpre += 1
      numsuf += 1
      assert_equal( "#{pre * numpre}#{suf * numsuf}", str )

      str.prefix! pre
      numpre += 1
      assert_equal( "#{pre * numpre}#{suf * numsuf}", str )

      str.suffix! suf
      numsuf += 1
      assert_equal( "#{pre * numpre}#{suf * numsuf}", str )
    end
  end

end

