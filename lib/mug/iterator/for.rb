
require_relative '../iterator'

class Object
  #
  # Creates an Iterator object, which is a subclass of Enumerator
  # that recursively invokes a method on an object.
  #
  # Initially the receiving object is +self+. After each iteration,
  # the receiving object is replaced with the result of the previous
  # iteration.
  #
  # @param meth [Symbol] the method name to invoke on each iteration
  # @param args [Array] additional arguments passed to the method
  # @return [Iterator] a new Iterator instance
  #
  # @example
  #   require 'mug/iterator/for'
  #   0.iter_for(:next).take(5)  #=> [1, 2, 3, 4, 5]
  #   0.iter_for(:+, 2).take(5)  #=> [2, 4, 6, 8, 10]
  #
  def iter_for meth, *args
    Iterator.new(self) do |o|
      o.send(meth, *args)
    end
  end
  alias to_iter iter_for
end

=begin
Copyright (c) 2013-2026, Matthew Kerwin <matthew@kerwin.net.au>

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

