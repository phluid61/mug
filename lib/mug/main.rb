
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
  # @yield optional block to execute when in the main file
  # @return [Boolean, Object, nil] +true+ if in main (no block), block result
  #   (with block), or +nil+ if not in main
  #
  # @example Without a block
  #   require 'mug/main'
  #   if __main__
  #     puts "the main file"
  #   end
  #
  # @example With a block
  #   require 'mug/main'
  #   __main__ do
  #     puts "also the main file"
  #   end
  #
  def __main__
    cloc = caller_locations(1, 1)[0]
    return if cloc.nil?
    return unless File.absolute_path($0) == cloc.absolute_path
    block_given? ? (yield) : true
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
