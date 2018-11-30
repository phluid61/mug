
class Array

  #
  # Deletes every element of +self+ for which block evaluates to +true+.
  #
  # Returns an array of the deleted elements.
  #
  # If no block is given, an Enumerator is returned instead.
  #
  # See #delete_if, #reject!
  #
  def delete_all &_block
    return enum_for :delete_all unless block_given?
    [].tap do |removed|
      delete_if do |e|
        if yield e
          removed << e
          true
        end
      end
    end
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


