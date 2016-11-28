
class Integer

  ##
  # Tests common bits in +this+ AND +other+.
  #
  # test:
  #   :any  => true if any bits are set
  #   :all  => true if all bits are set
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
  def and_any? other
    return false if other.zero?
    self & other != 0
  end

  ##
  # True if +this+ AND +other+ is +other+.
  #
  # i.e. if all set bits in +other+ are set in +this+.
  #
  def and_all? other
    return false if other.zero?
    self & other == other
  end

  ##
  # True if +this+ OR +other+ is non-zero.
  #
  def or? other
    self | other != 0
  end

  ##
  # True if +this+ XOR +other+ is non-zero.
  #
  def xor? other
    self ^ other != 0
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
