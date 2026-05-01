
class Integer

  ##
  # Tests common bits in +this+ AND +other+.
  #
  # test:
  #   :any  => true if any bits are set
  #   :all  => true if all bits are set
  #
  # @param other [Integer] the bitmask to test against
  # @param test [Symbol] +:any+ or +:all+
  # @return [Boolean] whether the bit test passes
  # @raise [ArgumentError] if +test+ is not +:any+ or +:all+
  #
  # @example
  #   require 'mug/bittest'
  #   0b1010.and?(0b1000, test: :any)  #=> true
  #   0b1010.and?(0b1100, test: :all)  #=> false
  #
  # @see #and_any?
  # @see #and_all?
  #
  def and? other, test: :any
    case test.to_sym
    when :any
      and_any? other
    when :all
      and_all? other
    else
      raise ArgumentError, "invalid value for 'test' (given #{test.inspect}, should be :any or :all)"
    end
  end

  ##
  # True if +this+ AND +other+ is non-zero.
  #
  # i.e. if any set bits in +other+ are set in +this+.
  #
  # @param other [Integer] the bitmask to test against
  # @return [Boolean] whether any set bits in +other+ are set in +this+
  #
  # @example
  #   require 'mug/bittest'
  #   0b1010.and_any?(0b1000)  #=> true
  #   0b1010.and_any?(0b0100)  #=> false
  #
  # @note Similar to +Integer#anybits?+ (Ruby 2.5+).
  #
  def and_any? other
    return false if other.zero?
    self & other != 0
  end

  ##
  # True if +this+ AND +other+ is +other+.
  #
  # i.e. if all set bits in +other+ are set in +this+.
  #
  # @param other [Integer] the bitmask to test against
  # @return [Boolean] whether all set bits in +other+ are set in +this+
  #
  # @example
  #   require 'mug/bittest'
  #   0b1110.and_all?(0b1010)  #=> true
  #   0b1010.and_all?(0b1100)  #=> false
  #
  # @note Similar to +Integer#allbits?+ (Ruby 2.5+).
  #
  def and_all? other
    return false if other.zero?
    self & other == other
  end

  ##
  # True if +this+ OR +other+ is non-zero.
  #
  # @param other [Integer] the value to OR with
  # @return [Boolean] whether +this+ OR +other+ is non-zero
  #
  # @example
  #   require 'mug/bittest'
  #   0b1010.or?(0b0000)  #=> true
  #   0b0000.or?(0b0000)  #=> false
  #
  # @note No stdlib equivalent exists.
  #
  def or? other
    self | other != 0
  end

  ##
  # True if +this+ XOR +other+ is non-zero.
  #
  # @param other [Integer] the value to XOR with
  # @return [Boolean] whether +this+ XOR +other+ is non-zero
  #
  # @example
  #   require 'mug/bittest'
  #   0b1010.xor?(0b1010)  #=> false
  #   0b1010.xor?(0b0101)  #=> true
  #
  # @note No stdlib equivalent exists.
  #
  def xor? other
    self ^ other != 0
  end

end

=begin
Copyright (c) 2016-2026, Matthew Kerwin <matthew@kerwin.net.au>

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
