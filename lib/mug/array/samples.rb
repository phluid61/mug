
class Array

  #
  # Choose a random subset of elements from the array.
  #
  # The elements are chosen by using random and unique indices into the
  # array in order to ensure that an element doesn't repeat itself
  # unless the array already contained duplicate elements.
  #
  # If the array is empty, always returns an empty array.
  #
  # The optional +min+ and +max+ arguments restrict the size of the
  # returned array.  +min+ must be >= 0, and +max+ must be >= +min+.
  # (Both values are clamped to the size of the array.)
  #
  # The optional +random+ argument will be used as the random number
  # generator.
  #
  def samples min: nil, max: nil, random: nil
    min = 1 if min.nil?
    min = length if min > length

    max = length if max.nil?
    max = length if max > length

    raise ArgumentError, "min must be >= 0 (#{min})" if min < 0
    raise ArgumentError, "min (#{min}) must be <= max (#{max})" if min > max

    if random
      n = random.rand(min..max)
      sample n, random: random
    else
      n = rand(min..max)
      sample n
    end
  end

end

=begin
Copyright (c) 2016, Matthew Kerwin <matthew@kerwin.net.au>

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

