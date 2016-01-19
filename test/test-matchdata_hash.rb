require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/matchdata/hash'
class Test_matchdata_hash < Test::Unit::TestCase
	def test__matchdata__to_h
		str = 'a12b'
		[
			[/(    \d)(    \d)/x.match(str), { 1 =>'1',  2 =>'2'}],
			[/(?<x>\d)(?<y>\d)/x.match(str), {'x'=>'1', 'y'=>'2'}],
			[/(    \d)(?<y>\d)/x.match(str), {          'y'=>'2'}], # ):
		].each do |m, x|
			assert_equal( x, m.to_h )
		end
	end
	def test__matchdata__named_captures
		str = 'a12b'
		[
			[/(    \d)(    \d)/x.match(str), {                  }],
			[/(?<x>\d)(?<y>\d)/x.match(str), {'x'=>'1', 'y'=>'2'}],
			[/(    \d)(?<y>\d)/x.match(str), {          'y'=>'2'}],
		].each do |m, x|
			assert_equal( x, m.named_captures )
		end
	end
	def test__matchdata__positional_captures
		str = 'a12b'
		[
			[/(    \d)(    \d)/x.match(str), { 1 =>'1',  2 =>'2'}],
			[/(?<x>\d)(?<y>\d)/x.match(str), {                  }],
			[/(    \d)(?<y>\d)/x.match(str), {                  }], # D:
		].each do |m, x|
			assert_equal( x, m.positional_captures )
		end
	end
	def test__matchdata__positional_captures2
		str = 'a12b'
		[
			[/(    \d)(    \d)/x.match(str), { 1 =>'1',  2 =>'2'}],
			[/(?<x>\d)(?<y>\d)/x.match(str), { 1 =>'1',  2 =>'2'}],
			[/(    \d)(?<y>\d)/x.match(str), { 1 =>'2'}],           # ):
		].each do |m, x|
			assert_equal( x, m.positional_captures(include_names: true) )
		end
	end
end

