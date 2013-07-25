
module Math
  # The true circle constant.
  # The ratio of a circle's circumference to its radius.
  TAU = PI * 2.0
end

module BigMath
  ##
  # Computes the value of tau to the specific number of digits of precision.
  #
  # @param [Integer] prec the number of decimal digits of precision in the computed value.
  # @return [BigDecimal] the computed value
  # @raise [ArgumentError] if +prec+ is not positive
  #
  # @example
  #   require 'bigdecimal'
  #   require 'bigdecimal/math'
  #   include BigMath
  #
  #   puts TAU(150)
  #
  def TAU(prec)
    raise ArgumentError, 'Zero or negative argument for TAU' if prec <= 0
    PI(prec) * BigDecimal('2')
  end
end

=begin
Copyright (c) 2013, Matthew Kerwin <matthew@kerwin.net.au>

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED 'AS IS' AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
=end

