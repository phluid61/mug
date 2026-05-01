
class Object

  ##
  # Test for logical equivalence.
  #
  # Returns true if +condition+ and +obj+ are either
  # both truthy, or both falsey.
  #
  # @param condition [Object] a value to test against +self+
  # @yield when no positional argument is given, yields to obtain the condition
  # @return [Boolean] +true+ if both +self+ and +condition+ are truthy or
  #   both are falsey; +false+ otherwise
  #
  # @example
  #   require 'mug/iff'
  #   "hello".iff?(true)   #=> true
  #   "hello".iff?(false)  #=> false
  #   nil.iff?(false)      #=> true
  #   nil.iff?(true)       #=> false
  #
  def iff? *condition
    if condition.length == 1
      cond = condition[0]
    elsif condition.empty? && block_given?
      cond = yield
    else
      raise ArgumentError, "wrong number of arguments (given #{condition.length}, expected 1)"
    end
    cond ? !!self : !self
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
