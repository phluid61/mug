
module Kernel
  #
  # Negate a predicate.
  #
  # When called with no arguments and no block, negates this object.
  # When called with arguments, sends the arguments as a method call
  # to this object and negates the result.
  # When called with a block (and no arguments), yields this object
  # to the block and negates the result.
  #
  # @param a [Array] arguments to send as a method call
  # @yield [o] optionally yields self to the block
  # @yieldparam o [Object] this object
  # @return [Boolean] the negated result
  #
  # @example
  #   require 'mug/not'
  #   false.not              #=> true
  #   true.not               #=> false
  #   [].not(:empty?)        #=> false
  #   [1].not(:empty?)       #=> true
  #   [1,-2,3].not(:all?) {|e| e > 0 }  #=> true
  #
  def not(*a, &b)
    not a.empty? ? (b ? (yield self) : self) : __send__(*a, &b)
  end
end

=begin
Copyright (c) 2016-2026, Matthew Kerwin <matthew@kerwin.net.au>

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

Additional license is granted to the Ruby Core Team to use this software
in the ruby core or ruby standard libraries without including the above
copyright notice nor this permission notice.  Subsequently, such a copy
of this software becomes wholly subject to the relevant licensing terms
of the ruby core or ruby standard libraries.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
=end

