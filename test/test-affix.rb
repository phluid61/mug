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
    d = "#{pre}#{str}#{pre}"

    assert_equal( a, str.affix(pre, suf) )
    assert_equal( b, str.prefix(pre) )
    assert_equal( c, str.suffix(suf) )
    assert_equal( d, str.affix(pre) )
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

  def test_affix_bang2
    str = ''
    pre = '+'

    3.times do |i|
      n = i * 2

      str.affix! pre
      n += 2
      assert_equal( "#{pre * n}", str )
    end
  end

  def test_affix?
    str = "abc"
    [
      # obvious cases
      [ 'a', 'c',  true],
      [ /a/, /c/,  true],
      [/^a/, /c$/, true],
      # expected edges
      ['','', true],
      ['abc','', true],
      ['','abc', true],
      # failures
      ['x','c', false],
      ['a','x', false],
      ['ab','bc', false],
      [/../,/../, false],
    ].each do |p, s, x|
      assert_equal( x, str.affix?(p, s) )
    end

    str = "xyx"
    [
      # obvious cases
      [ 'x', true],
      [ /x/, true],
      # expected edges
      ['', true],
      [/^x|x$/, true],
      # failures
      ['a', false],
      [/../, false],
    ].each do |p, x|
      assert_equal( x, str.affix?(p) )
    end
  end

  def test_prefix?
    str = "abc"
    [
      # obvious cases
      [ 'a', true],
      [ /a/, true],
      [/^a/, true],
      # expected edges
      ['', true],
      ['abc', true],
      # failures
      ['x', false],
      ['abcd', false],
      [/..../, false],
    ].each do |p, x|
      assert_equal( x, str.prefix?(p) )
    end
  end

  def test_suffix?
    str = "abc"
    [
      # obvious cases
      ['c',  true],
      [/c/,  true],
      [/c$/, true],
      # expected edges
      ['', true],
      ['abc', true],
      # failures
      ['x', false],
      ['zabc', false],
      [/..../, false],
    ].each do |s, x|
      assert_equal( x, str.suffix?(s) )
    end
  end

end

