
module Kernel

  ##
  # Compares the calling source filename with `$PROGRAM_NAME` (`$0`).
  #
  # Returns a falsey value if the calling context is not in the 'main' file.
  #
  # If called without a block, and the calling context is in the 'main' file,
  # returns +true+.
  #
  # If called with a block, and the calling context is in the 'main' file, the
  # block is executed and the result is returned.
  #
  def __main__
    cloc = caller_locations(1, 1)[0]
    return if cloc.nil?
    return unless File.absolute_path($0) == cloc.absolute_path
    block_given? ? (yield) : true
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
