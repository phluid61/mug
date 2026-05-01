
#
# A special class of Enumerator that repeatedly yields values
# to a block.
#
# The initial yielded value is given in the constructor, but in
# subsequent iterations the result of the previous iteration is
# yielded.
#
# @note Similar to +Enumerator.produce+ (Ruby 2.7+), but
#   +Enumerator.produce+ includes the initial value in its output.
#
# @example
#   require 'mug/iterator/for'
#   0.iter_for(:next).take(5) #=> [1,2,3,4,5]
#
class Iterator < Enumerator
  #
  # Creates a new Iterator object, which can be used as an
  # Enumerable.
  #
  # In the first form, iteration is defined by the given block,
  # to which the current object and any other +args+ are yielded.
  #
  # In the second, deprecated, form, a generated Iterator sends the
  # given method with any +args+ to the iterand.
  #
  # Use of this form is discouraged.  Use Object#iter_for or
  # Method#to_iter instead.
  #
  # @param obj [Object] the initial value for iteration
  # @param args [Array] additional arguments passed to the block or method
  # @yield [current, *args] block defining the iteration logic
  # @yieldparam current [Object] the current iteration value
  # @yieldreturn [Object] the next iteration value
  # @return [Iterator] a new Iterator instance
  #
  # @example Block form
  #   require 'mug/iterator'
  #   Iterator.new(1) { |n| n * 2 }.take(5) #=> [2, 4, 8, 16, 32]
  #
  # @call-seq new(initial, *args) { |obj, *args| ... }
  # @call-seq new(initial, method=:each, *args)
  #
  def initialize obj, *args
    if block_given?
      super() do |y|
        loop do
          y << (obj = yield obj, *args)
        end
      end
    else
      warn 'Iterator.new without a block is deprecated; use Object#to_iter'
      args = [:each] if args.empty?
      super() do |y|
        loop do
          y << (obj = obj.send(*args))
        end
      end
    end
  end
end

=begin
Copyright (c) 2013-2026, Matthew Kerwin <matthew@kerwin.net.au>

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
=end

