
class Numeric

  # Returns +true+ if this number is negative (i.e. < 0), +false+ otherwise.
  #
  # @return [Boolean]
  #
  # @example
  #   require 'mug/negativity'
  #   -1.negative?  #=> true
  #   0.negative?   #=> false
  #   1.negative?   #=> false
  def negative?
    self < 0
  end

  # Returns +true+ if this number is positive (i.e. > 0), +false+ otherwise.
  #
  # @return [Boolean]
  #
  # @example
  #   require 'mug/negativity'
  #   1.positive?   #=> true
  #   0.positive?   #=> false
  #   -1.positive?  #=> false
  def positive?
    self > 0
  end

  # Returns +true+ if this number is nonnegative (i.e. >= 0), +false+ otherwise.
  #
  # @return [Boolean]
  #
  # @example
  #   require 'mug/negativity'
  #   1.nonnegative?   #=> true
  #   0.nonnegative?   #=> true
  #   -1.nonnegative?  #=> false
  def nonnegative?
    self >= 0
  end

  # Returns +true+ if this number is nonpositive (i.e. <= 0), +false+ otherwise.
  #
  # @return [Boolean]
  #
  # @example
  #   require 'mug/negativity'
  #   -1.nonpositive?  #=> true
  #   0.nonpositive?   #=> true
  #   1.nonpositive?   #=> false
  def nonpositive?
    self <= 0
  end

  # If this number is negative (i.e. < 0), returns itself, otherwise returns +nil+.
  #
  # @return [Numeric, nil]
  #
  # @example
  #   require 'mug/negativity'
  #   -1.negative!  #=> -1
  #   0.negative!   #=> nil
  #   1.negative!   #=> nil
  def negative!
    self < 0 ? self : nil
  end

  # If this number is positive (i.e. > 0), returns itself, otherwise returns +nil+.
  #
  # @return [Numeric, nil]
  #
  # @example
  #   require 'mug/negativity'
  #   1.positive!   #=> 1
  #   0.positive!   #=> nil
  #   -1.positive!  #=> nil
  def positive!
    self > 0 ? self : nil
  end

  # If this number is nonnegative (i.e. >= 0), returns itself, otherwise returns +nil+.
  #
  # @return [Numeric, nil]
  #
  # @example
  #   require 'mug/negativity'
  #   1.nonnegative!   #=> 1
  #   0.nonnegative!   #=> 0
  #   -1.nonnegative!  #=> nil
  def nonnegative!
    self >= 0 ? self : nil
  end

  # If this number is nonpositive (i.e. <= 0), returns itself, otherwise returns +nil+.
  #
  # @return [Numeric, nil]
  #
  # @example
  #   require 'mug/negativity'
  #   -1.nonpositive!  #=> -1
  #   0.nonpositive!   #=> 0
  #   1.nonpositive!   #=> nil
  def nonpositive!
    self <= 0 ? self : nil
  end

end

class Complex
  undef :negative? if method_defined?(:negative?)
  undef :positive? if method_defined?(:positive?)
  undef :nonnegative?
  undef :nonpositive?
  undef :negative!
  undef :positive!
  undef :nonnegative!
  undef :nonpositive!
end

=begin
Copyright (c) 2015-2026, Matthew Kerwin <matthew@kerwin.net.au>

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

