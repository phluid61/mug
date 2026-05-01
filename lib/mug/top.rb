
module Enumerable

  #
  # Get the top +n+ items, in order from top to bottom.
  #
  # Returns an +Array+ even when +n+ is 1.
  #
  # @param n [Integer] the number of items to return
  # @yield [a, b] optional comparison block
  # @yieldparam a [Object] an element to compare
  # @yieldparam b [Object] an element to compare
  # @return [Array] the top +n+ items
  #
  # @note +top(n)+ is similar to +Enumerable#max(n)+ (Ruby 2.2+).
  #
  # @see Enumerable#sort
  #
  def top n=1, &_blk
    if block_given?
      sort{|x,y| yield y, x }[0...n]
    else
      #top_by(n) {|x| x }
      if n <= length
        sort[-n..-1].reverse
      else
        sort.reverse
      end
    end
  end

  #
  # Get the top +n+ items, in order from top to bottom, ordered
  # by mapping the values through the given block.
  #
  # Returns an +Array+ even when +n+ is 1. Values that are tied
  # after mapping are returned in the initial order.
  #
  # If no block is given, an enumerator is returned instead.
  #
  # @param n [Integer] the number of items to return
  # @yield [item] mapping block
  # @yieldparam item [Object] an element to map
  # @return [Array] the top +n+ items
  # @return [Enumerator] if no block is given
  #
  # @note Similar to +Enumerable#max_by(n)+ (Ruby 2.2+), but
  #   guarantees stable ordering among tied elements.
  #
  # @see Enumerable#sort_by
  #
  def top_by n=1, &_blk
    return enum_for(:top_by, n) unless block_given?
    chain = {}
    each do |x|
      y = yield x
      chain[y] ||= []
      chain[y] << x
    end
    ary = []
    chain.keys.sort.reverse.each do |k|
      ary += chain[k]
      break if ary.length > n
    end
    ary[0...n]
  end

  #
  # Get the bottom +n+ items, ordered from bottom to top.
  #
  # Returns an +Array+ even when +n+ is 1.
  #
  # @param n [Integer] the number of items to return
  # @yield [a, b] optional comparison block
  # @yieldparam a [Object] an element to compare
  # @yieldparam b [Object] an element to compare
  # @return [Array] the bottom +n+ items
  #
  # @note +bottom(n)+ is similar to +Enumerable#min(n)+ (Ruby 2.2+).
  #
  # @see Enumerable#sort
  #
  def bottom n=1, &blk
    if block_given?
      sort(&blk)[0...n]
    else
      #bottom_by(n) {|x| x }
      sort[0...n]
    end
  end

  #
  # Get the bottom +n+ items, in order from bottom to top, ordered
  # by mapping the values through the given block.
  #
  # Returns an +Array+ even when +n+ is 1. Values that are tied
  # after mapping are returned in the initial order.
  #
  # If no block is given, an enumerator is returned instead.
  #
  # @param n [Integer] the number of items to return
  # @yield [item] mapping block
  # @yieldparam item [Object] an element to map
  # @return [Array] the bottom +n+ items
  # @return [Enumerator] if no block is given
  #
  # @note Similar to +Enumerable#min_by(n)+ (Ruby 2.2+), but
  #   guarantees stable ordering among tied elements.
  #
  # @see Enumerable#sort_by
  #
  def bottom_by n=1, &_blk
    return enum_for(:bottom_by, n) unless block_given?
    chain = {}
    each do |x|
      y = yield x
      chain[y] ||= []
      chain[y] << x
    end
    ary = []
    chain.keys.sort.each do |k|
      ary += chain[k]
      break if ary.length > n
    end
    ary[0...n]
  end

end

class Array
  # Replaces this array with the top +n+ items in place.
  #
  # @param n [Integer] the number of items to keep
  # @yield [a, b] optional comparison block
  # @return [Array] self
  # @see Enumerable#top
  def top! n=1, &blk
    replace top(n, &blk)
  end

  # Replaces this array with the top +n+ items (by mapping) in place.
  #
  # @param n [Integer] the number of items to keep
  # @yield [item] mapping block
  # @return [Array] self
  # @return [Enumerator] if no block is given
  # @see Enumerable#top_by
  def top_by! n=1, &blk
    return enum_for(:top_by!, n) unless block_given?
    replace top_by(n, &blk)
  end

  # Replaces this array with the bottom +n+ items in place.
  #
  # @param n [Integer] the number of items to keep
  # @yield [a, b] optional comparison block
  # @return [Array] self
  # @see Enumerable#bottom
  def bottom! n=1, &blk
    replace bottom(n, &blk)
  end

  # Replaces this array with the bottom +n+ items (by mapping) in place.
  #
  # @param n [Integer] the number of items to keep
  # @yield [item] mapping block
  # @return [Array] self
  # @return [Enumerator] if no block is given
  # @see Enumerable#bottom_by
  def bottom_by! n=1, &blk
    return enum_for(:bottom_by!, n) unless block_given?
    replace bottom_by(n, &blk)
  end
end

=begin
Copyright (c) 2018-2026, Matthew Kerwin <matthew@kerwin.net.au>

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

