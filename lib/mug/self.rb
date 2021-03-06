
class Object
  #
  # Returns this object.
  #
  # If a block is given, this object is yielded to it, and the result
  # is returned.
  #
  def self(&_block)
    if block_given?
      yield self
    else
      self
    end
  end
  alias itself self

  # Deprecated alias for #self
  def yield(&block) #:nodoc:
    warn 'Object#yield is deprecated; use Object#self'
    self.self(&block)
  end

  #
  # Yields this object (and any other arguments)
  # to a block. If no block is given, returns an
  # Enumerator.
  #
  def revapply(*args, &_block)
    if block_given?
      yield self, *args
    else
      enum_for(:revapply, *args) { args.length + 1 }
    end
  end
  alias cede revapply
end

=begin
Copyright (c) 2018, Matthew Kerwin <matthew@kerwin.net.au>

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

