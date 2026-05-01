
#
# Converts arg to a boolean (true or false).
#
# Returns the truthiness of +obj+, as either +true+ or +false+.
# This is functionally equivalent to calling <tt>!!arg</tt>.
#
# @param arg [Object] the object to convert
# @return [Boolean] the truthiness of +arg+
#
# @example
#   require 'mug/bool'
#   Bool(nil)    #=> false
#   Bool(0)      #=> true
#   Bool("hi")   #=> true
#
def Bool(arg)
  !!arg
end

class Object
  #
  # Returns the truthiness of +obj+, as either +true+ or +false+.
  # This is functionally equivalent to calling <tt>!!obj</tt>.
  #
  # @return [Boolean] the truthiness of +self+
  #
  # @example
  #   require 'mug/bool'
  #   "hello".to_bool  #=> true
  #   nil.to_bool      #=> false
  #
  def to_bool
    true
  end

  #
  # Converts +obj+ to a boolean using "typical" C-like conversion rules.
  #
  # The following values all become false:
  # * +0+, +0.0+, etc. (any numeric zero)
  # * +Float::NAN+
  # * +""+ (empty string)
  # * +[]+, <tt>{}</tt>, etc. (any Enumerable or Enumerator with no elements)
  # * any Exception
  #
  # All other values become true.
  #
  # @return [Boolean] C-like truthiness of +self+
  #
  # @example
  #   require 'mug/bool'
  #   "hello".to_b  #=> true
  #   "".to_b       #=> false
  #   42.to_b       #=> true
  #   0.to_b        #=> false
  #
  def to_b
    true
  end
end

def nil.to_bool; false; end
def nil.to_b; false; end
def false.to_bool; false; end
def false.to_b; false; end

class Numeric
  #
  # Converts num to a boolean.
  # Returns true if not zero.
  #
  # @return [Boolean] true if +self+ is non-zero
  #
  def to_b
    !self.zero?
  end
end

class Float
  #
  # Converts num to a boolean.
  # Returns true if not zero or NaN.
  # Note: -0.0 is false, and +/-infinity are true.
  #
  # @return [Boolean] true if +self+ is non-zero and not NaN
  #
  def to_b
    !(self.zero? || self.nan?)
  end
end

class String
  #
  # Converts str to a boolean.
  # Returns true if not empty.
  #
  # @return [Boolean] true if +self+ is non-empty
  #
  def to_b
    !empty?
  end
end

class Array
  #
  # Converts ary to a boolean.
  # Returns true if not empty.
  #
  # @return [Boolean] true if +self+ is non-empty
  #
  def to_b
    !empty?
  end
end

class Hash
  #
  # Converts hsh to a boolean.
  # Returns true if not empty.
  #
  # @return [Boolean] true if +self+ is non-empty
  #
  def to_b
    !empty?
  end
end

module Enumerable
  #
  # Converts enum to a boolean.
  # Returns true if there are any elements.
  #
  # @return [Boolean] true if +self+ contains any elements
  #
  def to_b
    any?{ true }
  end
end

class Enumerator
  #
  # Converts enum to a boolean.
  # Returns true if there are any elements.
  # An enumerator whose size cannot be calculated lazily is assumed to be true.
  #
  # @return [Boolean] true if +self+ has any elements (or size is unknown)
  #
  def to_b
    (s = size).nil? || s.to_b
  end
end

class Exception
  #
  # Converts ex to a boolean.
  # All Exceptions are considered false.
  #
  # @return [Boolean] always false
  #
  def to_b
    false
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

# vim: set ts=2 sts=2 sw=2 expandtab:
