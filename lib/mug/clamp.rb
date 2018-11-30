
class Numeric

  #
  # Clamps num so that lower <= new_num <= higher.
  #
  # Returns lower when num < lower, higher when num > higher, otherwise
  # num itself.
  #
  # Raises an exception if lower > higher
  #
  def clamp lower, higher=nil
    return lower.bound(self) if lower.is_a?(Range) && higher.nil?
    raise ArgumentError, 'range must not be negative' if lower > higher
    [[lower, self].max, higher].min
  end

end

class Range

  #
  # Bounds val so that first <= new_val <= last.
  #
  # Returns first when val < first, last when val > last, otherwise
  # val itself.
  #
  # Raises an exception if val >= end and the range is exclusive.
  #
  def bound val
    a = first
    return a if val < a

    b = last
    if val >= b
      raise ArgumentError, 'greater than or equal to the exclusive range' if exclude_end?
      return b
    end

    val
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

