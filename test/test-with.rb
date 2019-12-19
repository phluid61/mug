require 'test/unit'
$VERBOSE = true

class ::DummyClass
  def self.dummy_method
    :ok
  end
  def self.clobber_method
    :original
  end
end

require_relative '../lib/mug/with'
class Test_with < Test::Unit::TestCase

  def test_with
    input = [1, 'two', :three]
    output = nil

    with(*input) do |a, b, c|
      output = [a, b, c]
    end

    assert_equal( output, input )
  end

  def test_with__noblock
    input = [1, 'two', :three]
    output = nil

    enum = with(*input)
    assert_kind_of( Enumerator, enum )

    enum.each do |a, b, c|
      output = [a, b, c]
    end

    assert_equal( output, input )
  end

  def test_with__private
    assert_raise(NoMethodError) { Object.new.with }
  end

end

