
module Enumerable

  class <<self
    #
    # Invokes a block once for every element in a sequence of
    # Enumerables.
    #
    # @param enums [Array<Enumerable>] the enumerables to chain
    # @return [Enumerator] if no block is given
    # @return [void] if a block is given
    #
    # @example
    #   require 'mug/enumerable/chain'
    #   Enumerable.chain([1, 2], [3, 4]) {|x| puts x }
    #   # prints 1, 2, 3, 4
    #
    # @note The instance method +Enumerable#chain+ is provided as a
    #   polyfill for Ruby < 2.6. On Ruby 2.6+, the built-in
    #   +Enumerable#chain+ (which returns a lazy +Enumerator::Chain+)
    #   is used instead.
    #
    def chain *enums
      return enum_for(:chain, *enums) unless block_given?
      enums.each do |enum|
        enum.each {|*args| yield(*args) }
      end
    end
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

