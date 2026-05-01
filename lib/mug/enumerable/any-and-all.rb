
module Enumerable

  #
  # Passes each element of the collection to the given block. The method returns `true` if the
  # block contains elements that never return `false` or `nil`. If the block is not given, Ruby
  # adds an implicit block of `{ |obj| obj }` which will cause `any_and_all?` to return `true`
  # when none of the collection members are `false` or `nil`.
  #
  # @return [Boolean] true if the collection is non-empty and all elements are truthy
  #
  # @example
  #   require 'mug/enumerable/any-and-all'
  #   [1, 2, 3].any_and_all?        #=> true
  #   [1, nil, 3].any_and_all?      #=> false
  #   [].any_and_all?               #=> false
  #   [2, 4, 6].any_and_all?(&:even?)  #=> true
  #
  def any_and_all? &block
    block ||= proc {|obj| obj }

    result = false
    each do |x|
      return false unless block[x]
      result = true
    end
    result
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
