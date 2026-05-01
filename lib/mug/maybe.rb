
#
# Invokes methods on a wrapped object, if that object is truthy.
#
class MaybeDelegator
  #
  # Creates a new MaybeDelegator, wrapping +o+
  #
  # @param o [Object] the object to wrap
  # @return [MaybeDelegator]
  #
  def initialize o
    @o = o
  end

  #
  # Returns this MaybeDelegator object.
  #
  # @return [MaybeDelegator] self
  #
  def maybe
    self
  end

  # Calls the method on +@o+ if it's truthy.
  def method_missing *a, &b #:nodoc:
    @o && @o.send(*a, &b)
  end

  # This is a bit flakey, but I think it's meaningful.
  def respond_to_missing? meth, priv
    if @o
      @o.repond_to_missing? meth, priv
    else
      true
    end
  end
end

class Object
  #
  # Invokes a method on this object iff it is truthy, otherwise
  # returns this object.
  #
  # When a block is given, the block is invoked in the scope of
  # this object (i.e. +self+ in the block refers to this object).
  #
  # When no block is given, returns a MaybeDelegator that
  # conditionally delegates methods to this object.
  #
  # @yield the block is evaluated in the scope of this object
  # @return [Object, nil, false] the result of the block, or this object if falsy
  # @return [MaybeDelegator] if no block is given
  #
  # @example
  #   require 'mug/maybe'
  #   # Equivalent to: a && a.b && a.b.c
  #   # (block form)
  #   a.maybe{ b.maybe{ c } }
  #   # (delegator form)
  #   a.maybe.b.maybe.c
  #
  def maybe &b
    if b
      self && instance_eval(&b)
    else
      MaybeDelegator.new(self)
    end
  end
end

=begin
Copyright (c) 2013,2020-2026, Matthew Kerwin <matthew@kerwin.net.au>

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
