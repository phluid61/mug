
module Enumerable

  #
  # Returns a hash of item=>count showing how many
  # of each +item+ are in this Enumerable.
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
Copyright (c) 2018, Matthew Kerwin <matthew@kerwin.net.au>

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

