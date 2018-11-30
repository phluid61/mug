
class Object

  ##
  # Test for logical equivalence.
  #
  # Returns true if +condition+ and +obj+ are either
  # both truthy, or both falsey.
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
