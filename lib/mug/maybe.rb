
#
# Invokes methods on a wrapped object, if that object is truthy.
#
class MaybeDelegator
  #
  # Creates a new MaybeDelegator, wrapping +o+
  #
  def initialize o
    @o = o
  end

  #
  # Returns this MaybeDelegator object.
  #
  def maybe
    self
  end

  # Calls the method on +@o+ if it's truthy.
  def method_missing *a, &b #:nodoc:
    @o && @o.send(*a, &b)
  end
end

class Object
  #
  # Do something if this object is truthy.
  #
  # If a block is given, it is executed in the context of this
  # object, iff this object is neither +nil+ nor +false+.
  #
  # If no block is given, returns a MaybeDelegator object.
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
Copyright (c) 2013, Matthew Kerwin <matthew@kerwin.net.au>

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

