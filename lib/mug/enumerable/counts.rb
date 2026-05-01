
module Enumerable

  #
  # Returns a hash of item=>count showing how many
  # of each +item+ are in this Enumerable.
  #
  # @return [Hash] a hash mapping each item to its count, with a default value of 0
  #
  # @example
  #   require 'mug/enumerable/counts'
  #   %w(a b b).counts  #=> {'a'=>1, 'b'=>2}
  #
  # @note Similar to +Enumerable#tally+ (Ruby 2.7+). Unlike +tally+,
  #   the returned hash has a default value of 0 for missing keys.
  #
  def counts &block
    return counts_by(&block) if block_given?
    hsh = Hash.new{|h,k| h[k] = 0 }
    each do |k|
      hsh[k] += 1
    end
    hsh
  end

  #
  # Passes each element in turn to the block, and returns a
  # hash of result=>count.
  #
  # If no block is given, an enumerator is returned.
  #
  # @return [Hash] a hash mapping each block result to its count, with a default value of 0
  # @return [Enumerator] if no block is given
  #
  # @example
  #   require 'mug/enumerable/counts'
  #   %w(a b b).counts_by {|o| o.upcase }  #=> {'A'=>1, 'B'=>2}
  #
  # @note Similar to +Enumerable#tally+ (Ruby 2.7+). Unlike +tally+,
  #   the returned hash has a default value of 0 for missing keys.
  #
  def counts_by &_block
    return enum_for(:counts_by) unless block_given?
    hsh = Hash.new{|h,k| h[k] = 0 }
    each do |j|
      k = yield j
      hsh[k] += 1
    end
    hsh
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

