
class Array

  ##
  # Subtract elements from this array.
  #
  # This is similar to Array#- except that elements from this array are
  # removed only once per instance in +ary+.
  #
  # If +remainder+ is given and true, returns a second array which is
  # all elements in +ary+ that were not present in this array.
  #
  # @note For the single-argument case, +Array#minus+ is similar to
  #   +Array#difference+ (Ruby 2.6+). The +remainder:+ option and
  #   +Array#^+ have no stdlib equivalent.
  #
  # @param ary [Array] elements to subtract
  # @param remainder [Boolean] whether to return unmatched elements from +ary+
  # @return [Array] the resulting array (or a pair of arrays if +remainder:+ is true)
  #
  # @call-seq minus(ary)
  # @call-seq minus(ary, remainder: true)
  #
  def minus ary, remainder: false

    result = dup
    rem = []

    ary.each do |x|
      i = result.index x
      if i
        result.delete_at i
      elsif remainder
        rem << x
      end
    end

    if remainder
      [result, rem]
    else
      result
    end
  end

  ##
  # Get the elements unique to one of two arrays.
  #
  # Duplicates in either array are included only once.
  #
  # @param other [Array] the array to compare against
  # @return [Array] elements unique to one of the two arrays
  #
  def ^ other
    left = uniq
    right = []
    other.uniq.each do |x|
      if left.include? x
        left.delete x
      elsif ! right.include?(x)
        right << x
      end
    end
    left + right
  end

end

=begin
Copyright (c) 2017-2026, Matthew Kerwin <matthew@kerwin.net.au>

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

