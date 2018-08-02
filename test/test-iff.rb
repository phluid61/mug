require 'test/unit'
$VERBOSE = true

require_relative '../lib/mug/iff'
class Test_iff < Test::Unit::TestCase

  def test_iff
    truthy = [true, 1, Object.new]
    falsey = [false, nil]

    truthy.each do |cond|
      truthy.each do |obj|
        assert( obj.iff?(cond) )
      end
      falsey.each do |obj|
        assert( !( obj.iff?(cond) ) )
      end
    end

    falsey.each do |cond|
      truthy.each do |obj|
        assert( !( obj.iff?(cond) ) )
      end
      falsey.each do |obj|
        assert( obj.iff?(cond) )
      end
    end
  end

  def test_iff_block
    truthy = [true, 1, Object.new]
    falsey = [false, nil]

    truthy.each do |cond|
      truthy.each do |obj|
        assert(    obj.iff? do cond; end )
      end
      falsey.each do |obj|
        assert( !( obj.iff? do cond; end ) )
      end
    end

    falsey.each do |cond|
      truthy.each do |obj|
        assert( !( obj.iff? do cond; end ) )
      end
      falsey.each do |obj|
        assert(    obj.iff? do cond; end )
      end
    end
  end

end

