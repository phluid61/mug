
module Kernel
  #
  # Repeatedly executes the block, yielding the current iteration
  # count, which starts from +offset+. If no block is given, returns
  # an Enumerator.
  #
  # @note Similar to iterating with +(offset..).each+ (Ruby 2.6+).
  #
  # @param offset [Integer] the starting count value
  # @yield [i] yields the current iteration count
  # @yieldparam i [Integer] the current count
  # @return [Enumerator] if no block is given
  # @return [Integer] the final count value when the loop terminates
  #
  # @example
  #   require 'mug/loop-with'
  #   loop_with_index do |i|
  #     p i
  #     break
  #   end
  #
  def loop_with_index(offset=0)
    return enum_for(:loop_with_index, offset) unless block_given?
    c = 0 + offset
    begin
      while true
        yield c
        c += 1
      end
    rescue StopIteration
    end
    c
  end

  #
  # Repeatedly executes the block, yielding an arbitrary object, +obj+.
  #
  # @param obj [Object] the object to yield on each iteration
  # @yield [obj] yields the object on each iteration
  # @yieldparam obj [Object] the arbitrary object
  # @return [Enumerator] if no block is given
  # @return [Object] the yielded object when the loop terminates
  #
  # @example
  #   require 'mug/loop-with'
  #   arr = loop_with_object([]) do |a|
  #     s = gets.chomp
  #     throw StopIteration if s.empty?
  #     a << s
  #   end
  #
  def loop_with_object(obj)
    return obj=enum_for(:loop_with_object, obj) unless block_given?
    begin
      while true
        yield obj
      end
    rescue StopIteration
    end
    obj
  end
end

# vim: set ts=2 sts=2 sw=2 expandtab:
